include asm_x86_incs/atan_funcs.inc

.code
;;		extern "C" bool atan_avx2_ps(float const* x, int n, float* out);
atan_avx2_macro_ps			macro
							vcmpltps ymm2,ymm0,ymm7								;; sign2 = ymm2
							vcmpgtps ymm3,ymm1,ymmword ptr [tan_vals_ps + 32]	;; ymm3 = suptan3pi8
							vmovups ymm4,ymmword ptr [mone_ps]					;; ymm4 = -1
							vdivps ymm4,ymm4,ymm1
							vblendvps ymm1,ymm1,ymm4,ymm3  	
							vblendvps ymm7,ymm7,ymmword ptr [pi_o_2_ps],ymm3	;; y = ymm7 
							vmovups ymm4,ymmword ptr [tan_vals_ps + 32]			;; 
							vmovups ymm5,ymmword ptr [tan_vals_ps]			;;
							vcmpltps ymm4,ymm1,ymm4
							vcmpgtps ymm5,ymm1,ymm5
							vandps ymm5,ymm5,ymm4							;;	inf
							vsubps ymm4,ymm1,ymmword ptr [one_ps]
							vaddps ymm6,ymm1,ymmword ptr [one_ps]
							vdivps ymm4,ymm4,ymm6
							vblendvps ymm1,ymm1,ymm4,ymm5
							vblendvps ymm7,ymm7,ymmword ptr [pi_o_4_ps],ymm5
							vmulps ymm6,ymm1,ymm1								;; z = ymm6
							vmovups ymm0,ymmword ptr [atan_coef_ps]
							vfmadd213ps ymm0,ymm6,ymmword ptr [atan_coef_ps + 32]
							vfmadd213ps ymm0,ymm6,ymmword ptr [atan_coef_ps + 64]
							vfmadd213ps ymm0,ymm6,ymmword ptr [atan_coef_ps + 96]
							vmulps ymm0,ymm0,ymm6
							vfmadd213ps ymm0,ymm1,ymm1
							vaddps ymm7,ymm7,ymm0
							endm

atan_avx2_ps				proc uses ebx,
									x_ptr:ptr real4,
									n_arg:dword,
									out_ptr:ptr real4			
								
							mov ebx,x_ptr
							test ebx,1fh
							jnz done

							mov edx,out_ptr
							test edx,1fh
							jnz done

							mov ecx,n_arg
							cmp ecx,8
							jl too_short

							mov eax,ecx
							and ecx,0fffffff8h
							sub eax,ecx
							shr ecx,3

				@@:			vmovaps ymm0,ymmword ptr [ebx]						;; xx = ymm0
							vmovaps ymm1,ymm0								
							vandps ymm1,ymm1,ymmword ptr [pos_sign_mask_d]		;; x = ymm1
							vxorps ymm7,ymm7,ymm7
							;; ====
							atan_avx2_macro_ps
							;; ====
							vxorps ymm6,ymm7,ymmword ptr [neg_sign_mask_d]
							vblendvps ymm7,ymm7,ymm6,ymm2

							vmovapd ymmword ptr [edx],ymm7
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ebx]						;; xx = ymm0
							vmovaps ymm1,ymm0								
							vandps ymm1,ymm1,ymmword ptr [pos_sign_mask_d]		;; x = ymm1
							vxorps ymm7,ymm7,ymm7
							;; ====
							atan_avx2_macro_ps
							;; ====
							vxorps ymm6,ymm7,ymmword ptr [neg_sign_mask_d]
							vblendvps ymm7,ymm7,ymm6,ymm2

							movaps xmm6,xmm7	
							cmp ecx,4
							jl short rem_left
							vextractf128 xmm6,ymm7,1 
							movaps xmmword ptr [edx],xmm7
							add edx,16
							sub ecx,4
							jz done


			rem_left:		cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		movss real4 ptr [edx],xmm6
							jmp short done
			two_left:		insertps xmm2,xmm6,01000000b
							movss real4 ptr [edx],xmm6
							movss real4 ptr [edx + 4],xmm2	
							jmp short done
			three_left:		insertps xmm2,xmm6,01000000b
							insertps xmm4,xmm6,10000000b
							movss real4 ptr [edx],xmm6
							movss real4 ptr [edx + 4],xmm2
							movss real4 ptr [edx + 8],xmm4

			done:			vzeroupper	
							ret
atan_avx2_ps				endp

;;		extern "C" bool atan_avx2_pd(double const* x, int n, double* out);
atan_avx2_macro_pd			macro
							vcmpltpd ymm2,ymm0,ymm7								;; sign2 = ymm2
							vcmpgtpd ymm3,ymm1,ymmword ptr [tan_3pi_o_8_pd]		;; ymm3 = suptan3pi8
							vmovupd ymm4,ymmword ptr [mone_pd]					;; ymm4 = -1
							vdivpd ymm4,ymm4,ymm1
							vblendvpd ymm1,ymm1,ymm4,ymm3  	
							vblendvpd ymm7,ymm7,ymmword ptr [pi_o_2_pd],ymm3	;; y = ymm7 
							vxorpd ymm6,ymm6,ymm6								;; flag = ymm6
							vblendvpd ymm6,ymm6,ymmword ptr [one_pd],ymm3
							vmovupd ymm4,ymmword ptr [tan_3pi_o_8_pd]			;; 
							vmovupd ymm5,ymmword ptr [o_p_66_pd]				;;
							vcmplepd ymm4,ymm1,ymm4
							vcmplepd ymm5,ymm1,ymm5
							vandpd ymm5,ymm5,ymm4								;; inf = ymm5
							vmovupd ymm4,ymmword ptr [pi_o_4_pd]
							vblendvpd ymm7,ymm4,ymm7,ymm5
							vsubpd ymm4,ymm1,ymmword ptr [one_pd]
							vaddpd ymm3,ymm1,ymmword ptr [one_pd]
							vdivpd ymm4,ymm4,ymm3
							vblendvpd ymm1,ymm4,ymm1,ymm5
							vmovupd ymm5,ymmword ptr [pi_o_4_pd]
							vcmpeqpd ymm5,ymm5,ymm7
							vmovupd ymm3,ymmword ptr [two_pd]
							vblendvpd ymm6,ymm6,ymm3,ymm5						;; flag = ymm6
							vmulpd ymm4,ymm1,ymm1								;; z = ymm4
							vmovupd ymm5,ymmword ptr [atan_pcoefs_pd]
							vfmadd213pd ymm5,ymm4,ymmword ptr [atan_pcoefs_pd + 32]	;; tmp = ymm5
							vfmadd213pd ymm5,ymm4,ymmword ptr [atan_pcoefs_pd + 64]
							vfmadd213pd ymm5,ymm4,ymmword ptr [atan_pcoefs_pd + 96]
							vfmadd213pd ymm5,ymm4,ymmword ptr [atan_pcoefs_pd + 128]
							vmulpd ymm5,ymm4,ymm5
							vmovupd ymm3,ymmword ptr [atan_qcoefs_pd]				;; tm2 = ymm3
							vaddpd ymm3,ymm3,ymm4
							vfmadd213pd ymm3,ymm4,ymmword ptr [atan_qcoefs_pd + 32]	
							vfmadd213pd ymm3,ymm4,ymmword ptr [atan_qcoefs_pd + 64]	
							vfmadd213pd ymm3,ymm4,ymmword ptr [atan_qcoefs_pd + 96]	
							vfmadd213pd ymm3,ymm4,ymmword ptr [atan_qcoefs_pd + 128]	
							vdivpd ymm4,ymm5,ymm3
							vfmadd213pd ymm4,ymm1,ymm1 	
							vmovupd ymm5,ymmword ptr [more_bits_pd]
							vfmadd132pd	ymm5,ymm4,ymmword ptr [o_p_5_pd]
							vcmpeqpd ymm3,ymm6,ymmword ptr [two_pd]
							vblendvpd ymm4,ymm4,ymm5,ymm3
							vcmpeqpd ymm3,ymm6,ymmword ptr [one_pd]
							vmovupd ymm5,ymmword ptr [more_bits_pd]
							vaddpd ymm5,ymm4,ymm5
							vblendvpd ymm4,ymm4,ymm5,ymm3
							vaddpd ymm7,ymm7,ymm4
							endm

atan_avx2_pd				proc uses ebx,
									x_ptr:ptr real8,
									n_arg:dword,
									out_ptr:ptr real8		
								
							mov ebx,x_ptr
							test ebx,1fh
							jnz done

							mov edx,out_ptr
							test edx,1fh
							jnz done

							mov ecx,n_arg
							cmp ecx,4
							jl too_short

							mov eax,ecx
							and ecx,0fffffffch
							sub eax,ecx
							shr ecx,2

				@@:			vmovapd ymm0,ymmword ptr [ebx]						;; xx = ymm0
							vmovapd ymm1,ymm0								
							vandpd ymm1,ymm1,ymmword ptr [pos_sign_mask_q]		;; x = ymm1
							vxorpd ymm7,ymm7,ymm7
							;; =====
							atan_avx2_macro_pd
							;; =====
							vxorps ymm3,ymm7,ymmword ptr [neg_sign_mask_q]
							vblendvpd ymm7,ymm7,ymm3,ymm2
							vxorpd ymm4,ymm4,ymm4
							vcmpeqpd ymm4,ymm1,ymm4
							vblendvps ymm7,ymm7,ymm0,ymm4

							vmovapd ymmword ptr [edx],ymm7
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr [ebx]						;; xx = ymm0
							vmovapd ymm1,ymm0								
							vandpd ymm1,ymm1,ymmword ptr [pos_sign_mask_q]		;; x = ymm1
							vxorpd ymm7,ymm7,ymm7
							;; =====
							atan_avx2_macro_pd
							;; =====
							vxorps ymm3,ymm7,ymmword ptr [neg_sign_mask_q]
							vblendvpd ymm7,ymm7,ymm3,ymm2
							vxorpd ymm4,ymm4,ymm4
							vcmpeqpd ymm4,ymm1,ymm4
							vblendvps ymm7,ymm7,ymm0,ymm4

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		vmovsd real8 ptr [edx],xmm7   
							jmp short done
			two_left:		vmovsd real8 ptr [edx],xmm7
							movhlps xmm2,xmm7
							vmovsd real8 ptr [edx + 8],xmm2 
							jmp short done
			three_left:		vextractf128 xmm6,ymm7,1	
							movhlps xmm2,xmm7
							vmovsd real8 ptr [edx],xmm7
							vmovsd real8 ptr [edx + 8],xmm2
							vmovsd real8 ptr [edx + 16],xmm6

			done:			vzeroupper
							ret
atan_avx2_pd				endp
							end

