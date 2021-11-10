include asm_x86_incs/asin_funcs.inc

.code
;; extern "C" bool asin_avx2_pd(double const *x, int n, double *out);
asin_avx2_macro_pd			macro
							;; this is for a > 0.625 case
							vmovupd ymm3,ymmword ptr [one_pd]
							vsubpd ymm3,ymm3,ymm0							;; zz = ymm3
							vmovupd ymm4,ymmword ptr [asin_rcoefs_pd]
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_rcoefs_pd + 32] ;; p = ymm4 (num)
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_rcoefs_pd + 64]
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_rcoefs_pd + 96]
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_rcoefs_pd + 128]
							vmulpd ymm4,ymm4,ymm3

							vaddpd ymm5,ymm3,ymmword ptr [asin_scoefs_pd]
							vfmadd213pd ymm5,ymm3,ymmword ptr [asin_scoefs_pd + 32]	;; div
							vfmadd213pd ymm5,ymm3,ymmword ptr [asin_scoefs_pd + 64]	
							vfmadd213pd ymm5,ymm3,ymmword ptr [asin_scoefs_pd + 96]	
							vdivpd ymm4,ymm4,ymm5
							vaddpd ymm3,ymm3,ymm3
							vsqrtpd ymm3,ymm3				
							vmovupd ymm5,ymmword ptr [pi_o_4_pd]
							vsubpd ymm5,ymm5,ymm3									;; z = ymm5
							vfmadd213pd ymm3,ymm4,ymmword ptr [more_bits_pd]
							vsubpd ymm5,ymm5,ymm3
							vaddpd ymm5,ymm5,ymmword ptr[pi_o_4_pd]					;; z = ymm5
							;; this is for a <= 0.625 case:
							vmulpd ymm3,ymm0,ymm0									;; zz = ymm3
							vmovupd ymm4,ymmword ptr [asin_pcoefs_pd]				;; z = ymm4 (num)
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_pcoefs_pd + 32]
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_pcoefs_pd + 64]
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_pcoefs_pd + 96]
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_pcoefs_pd + 128]
							vfmadd213pd ymm4,ymm3,ymmword ptr [asin_pcoefs_pd + 160]
							vmulpd ymm4,ymm4,ymm3
							vaddpd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd]			;; denom
							vfmadd213pd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd + 32]	
							vfmadd213pd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd + 64]
							vfmadd213pd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd + 96]
							vfmadd213pd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd + 128]
							vdivpd ymm4,ymm4,ymm6
							vfmadd213pd	ymm4, ymm0,ymm0
							endm

asin_avx2_pd				proc uses ebx,
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


					@@:		vmovapd ymm0,ymmword ptr [ebx]					;; x = ymm0
							vxorpd ymm7,ymm7,ymm7
							vcmpltpd ymm7,ymm0,ymm7							;; sign = ymm7
							vandpd ymm0,ymm0,ymmword ptr [pos_sign_mask_q]	;; a = ymm0 = fabs(x)
							
							vcmpgtpd ymm1,ymm0,ymmword ptr [op625_pd]		;; ymm1 = a > 0.625
							vcmpltpd ymm2,ymm0,ymmword ptr [small_pd]		;; ymm2 = a < 1.0e-8	
							;; ====
							asin_avx2_macro_pd
							;; ====
							vblendvpd ymm6,ymm4,ymm5,ymm1							;; final z = ymm5
							;; invert sign of ymm0:
							vxorpd ymm1,ymm5,ymmword ptr [neg_sign_mask_q]
							vblendvpd ymm6,ymm6,ymm1,ymm7
							vblendvpd ymm6,ymm6,ymmword ptr [ebx],ymm2

							vmovapd ymmword ptr [edx],ymm6
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr [ebx]					;; x = ymm0
							vxorpd ymm7,ymm7,ymm7
							vcmpltpd ymm7,ymm0,ymm7							;; sign = ymm7
							vandpd ymm0,ymm0,ymmword ptr [pos_sign_mask_q]	;; a = ymm0 = fabs(x)
							
							vcmpgtpd ymm1,ymm0,ymmword ptr [op625_pd]		;; ymm1 = a > 0.625
							vcmpltpd ymm2,ymm0,ymmword ptr [small_pd]		;; ymm2 = a < 1.0e-8	
							;; ====
							asin_avx2_macro_pd
							;; ====
							vblendvpd ymm6,ymm4,ymm5,ymm1							;; final z = ymm5
							;; invert sign of ymm0:
							vxorpd ymm1,ymm5,ymmword ptr [neg_sign_mask_q]
							vblendvpd ymm6,ymm6,ymm1,ymm7
							vblendvpd ymm7,ymm6,ymmword ptr [ebx],ymm2

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
asin_avx2_pd				endp

;; extern "C" bool asin_avx2_ps(float const *x, int n, float *out);
asin_avx2_macro_ps			macro
							;; this is for a > 0.5 case
							vmovups ymm3,ymmword ptr [one_ps]
							vsubps ymm3,ymm3,ymm0							;; zz = ymm3
							vmulps ymm3,ymm3,ymmword ptr [op5_ps]
							vmulps ymm4,ymm0,ymm0
							vblendvps ymm4,	ymm4,ymm3,ymm1					;; z = ymm4
							vsqrtps ymm5,ymm4	
							vblendvps ymm6,ymm0,ymm5,ymm1					;; x = ymm6

							vmovups ymm3,ymmword ptr [asin_coef_ps]
							vfmadd213ps ymm3,ymm4,ymmword ptr [asin_coef_ps + 32]
							vfmadd213ps ymm3,ymm4,ymmword ptr [asin_coef_ps + 64]
							vfmadd213ps ymm3,ymm4,ymmword ptr [asin_coef_ps + 96]
							vfmadd213ps ymm3,ymm4,ymmword ptr [asin_coef_ps + 128]
							vmulps ymm3,ymm3,ymm4
							vfmadd213ps ymm3,ymm6,ymm6						;; z = ymm3

							vaddps ymm4,ymm3,ymm3							;; zz = ymm4
							vmovups ymm5,ymmword ptr [pi_o_2_ps]
							vsubps ymm4,ymm5,ymm4
							vblendvps ymm3,ymm3,ymm4,ymm1
							vblendvps ymm3,ymm3,ymm6,ymm2

							endm
asin_avx2_ps				proc uses ebx,
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


					@@:		vmovaps ymm0,ymmword ptr [ebx]					;; x = ymm0
							vmovaps	ymm6,ymm0
							vxorps ymm7,ymm7,ymm7
							vcmpltps ymm7,ymm0,ymm7							;; sign = ymm7 = x < 0.0
							vandps ymm0,ymm0,ymmword ptr [pos_sign_mask_d]	;; a = ymm0 = fabs(x)
							
							vcmpgtps ymm1,ymm0,ymmword ptr [op5_ps]			;; ymm1 = a > 0.5
							vcmpltps ymm2,ymm0,ymmword ptr [small_ps]		;; ymm2 = a < 1.0e-4	
							;; ====
							asin_avx2_macro_ps
							;; ====
							vxorps ymm5, ymm3,ymmword ptr [neg_sign_mask_d]
							vblendvps ymm3,ymm3,ymm5,ymm7

							vmovaps ymmword ptr [edx],ymm3
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ebx]					;; x = ymm0
							vmovaps	ymm6,ymm0
							vxorps ymm7,ymm7,ymm7
							vcmpltps ymm7,ymm0,ymm7							;; sign = ymm7 = x < 0.0
							vandps ymm0,ymm0,ymmword ptr [pos_sign_mask_d]	;; a = ymm0 = fabs(x)
							
							vcmpgtps ymm1,ymm0,ymmword ptr [op5_ps]			;; ymm1 = a > 0.5
							vcmpltps ymm2,ymm0,ymmword ptr [small_ps]		;; ymm2 = a < 1.0e-4	
							;; ====
							asin_avx2_macro_ps
							;; ====
							vxorps ymm5, ymm3,ymmword ptr [neg_sign_mask_d]
							vblendvps ymm3,ymm3,ymm5,ymm7

							movaps xmm6,xmm3	
							cmp ecx,4
							jl short rem_left
							vextractf128 xmm6,ymm3,1 
							movaps xmmword ptr [edx],xmm3
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
asin_avx2_ps				endp
							end