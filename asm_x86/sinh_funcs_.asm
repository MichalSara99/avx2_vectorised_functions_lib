include asm_x86_incs/sinh_funcs.inc

.code
;;	extern "C" bool sinh_avx2_pd(double const *in,int n,double *out);
sinh_avx2_macro_pd			macro
							vandpd ymm1,ymm0,ymmword ptr [pos_sign_mask_q]								;; a = ymm1
							vmovupd ymm2,ymmword ptr [loge2_pd]
							vaddpd ymm3,ymm2,ymmword ptr [max_log_pd]									;; max = ymm3
							vcmpgtpd ymm3,ymm0,ymm3														;; max_mask = ymm3
							vsubpd ymm2,ymm2,ymmword ptr [min_log_pd]									;; min = ymm2
							vcmpgtpd ymm2,ymm0,ymm2														;; min_mask = ymm2
							vorpd ymm5,ymm2,ymm3														;; bound_mask = ymm5
							vmovupd ymm2,ymmword ptr [max_log_pd]										
							vsubpd ymm2,ymm2,ymmword ptr [loge2_pd]										;; msk = ymm2
							vcmpgepd ymm2,ymm1,ymm2														;; msk_sign = ymm2
							vxorpd ymm4,ymm4,ymm4
							vblendvpd ymm6,ymm4,ymmword ptr [one_pd],ymm2								;; sign_1 = ymm6

							;; first branch:
							vmovupd ymm2,ymmword ptr [one_half_pd]
							vmulpd ymm2,ymm2,ymm6
							vmovupd ymm3,ymmword ptr [one_pd]
							vsubpd ymm0,ymm3,ymm2
							vmulpd ymm0,ymm0,ymm1

							;; exp starts here:
							vmovupd ymm1,ymmword ptr [log2e_pd]
							vmulpd ymm1,ymm1,ymm0														;; a = ymm1
							vmovapd ymm2,ymm1															;; a = ymm2
							vcmpltpd ymm2,ymm2, ymm4													;; p = ymm2
							vandpd ymm2,ymm2,ymmword ptr [one_pd]										;; p = ymm2
							vsubpd ymm1,ymm1,ymm2														;; a = ymm1
							vextractf128 xmm3,ymm1,0													;; a_l = xmm3
							vextractf128 xmm4,ymm1,1													;; a_h = xmm4	
							;; this could be macro:
							vsubpd xmm3,xmm3 ,xmmword ptr [opfournine_pd]
							vaddpd xmm3,xmm3,xmmword ptr [long_real]	
							vpsubq xmm3,xmm3,xmmword ptr [long_real]
							vsubpd xmm4,xmm4,xmmword ptr [opfournine_pd]
							vaddpd xmm4,xmm4,xmmword ptr [long_real]									;; k_l = xmm3
							vpsubq xmm4,xmm4,xmmword ptr [long_real]									;; k_h = xmm4

							vroundpd ymm1,ymm1,00000001b												;; p = ymm1
							vmulpd ymm2,ymm1,ymmword ptr [c1_pd]										;; a = ymm2
							vsubpd ymm0,ymm0,ymm2														;; x = ymm0
							vmulpd ymm2,ymm1,ymmword ptr [c2_pd]										;; a = ymm2
							vsubpd ymm0,ymm0,ymm2														;; x = ymm0
							vmulpd ymm2,ymm0,ymmword ptr [m_ecoef_pd]
							vaddpd ymm2,ymm2,ymmword ptr [m_ecoef_pd + 32]								;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 64]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 96]							;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 128]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 160]						;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 192]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 224]						;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 256]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 288]						;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 320]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 352]						;; a = ymm2

							;; p = 2^k
							vpaddq xmm3,xmm3, xmmword ptr [int_tentwothree] 
							vpaddq xmm4,xmm4, xmmword ptr [int_tentwothree]
							vinsertf128 ymm3,ymm3,xmm4,1
							vpsllq ymm3,ymm3,52															;; k = ymm3
							vmulpd ymm3,ymm3,ymm2														;; a_first = ymm3

							;; exp ends here:
							vsubpd ymm2,ymm3,ymmword ptr [one_pd]										;; tnp_first = ymm2
							vfmadd213pd ymm2,ymm6,ymmword ptr [one_pd]
							vmulpd ymm2,ymm2,ymm3
							vmulpd ymm2,ymm2,ymmword ptr [one_half_pd]
							vmovupd ymm0,ymmword ptr [one_pd]
							vsubpd ymm0,ymm0,ymm6														;; tmp_second = ymm0
							vmovupd ymm1,ymmword ptr [two_pd]
							vmulpd ymm1,ymm1,ymm3
							vdivpd ymm0,ymm0,ymm1
							vsubpd ymm3,ymm2,ymm0														;; a_first =ymm3
							vxorpd ymm0,ymm3,ymmword ptr [neg_sign_mask_q]								;; ma = ymm0
							vcmpltpd ymm1,ymm7,ymmword ptr [one_pd]										;; a_mask = ymm1
							vblendvpd ymm3,ymm3,ymm0,ymm1												;; a_first =ymm3
							vandpd ymm1,ymm7,ymmword ptr [pos_sign_mask_q]								;; a = ymm1
							vmulpd ymm1,ymm1,ymm1														;; a_second = ymm1
							vmovupd ymm0,ymmword ptr [sinh_pcoef_pd]									;; p1 = ymm0
							vfmadd213pd ymm0,ymm1,ymmword ptr [sinh_pcoef_pd + 32]	
							vfmadd213pd ymm0,ymm1,ymmword ptr [sinh_pcoef_pd + 64]	
							vfmadd213pd ymm0,ymm1,ymmword ptr [sinh_pcoef_pd + 96]	
							vmulpd ymm0,ymm0,ymm1
							vmulpd ymm0,ymm0,ymm7
							vaddpd ymm4,ymm1,ymmword ptr [sinh_qcoef_pd]								;; q1 = ymm4
							vfmadd213pd	ymm4,ymm1,ymmword ptr [sinh_qcoef_pd + 32]
							vfmadd213pd	ymm4,ymm1,ymmword ptr [sinh_qcoef_pd + 64]
							vdivpd ymm0,ymm0,ymm4
							vaddpd ymm0,ymm0,ymm7
							vandpd ymm1,ymm7,ymmword ptr [pos_sign_mask_q]								;; a = ymm1
							vcmpgtpd ymm1,ymm1,ymmword  ptr[one_pd]
							vblendvpd ymm1,ymm0,ymm3,ymm1												;; res =ymm1
							vblendvpd ymm1,ymm1,ymmword ptr [bignum_pd],ymm5
							endm

sinh_avx2_pd				proc uses ebx,
									x_ptr:ptr real8,
									n_arg:dword,
									out_ptr:ptr real8
						
							xor eax,eax

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


				 @@:		vmovapd ymm0,ymmword ptr [ebx]												;; x = ymm0		
							vmovapd ymm7,ymm0		
							;; ======
							sinh_avx2_macro_pd
							;; ======
							vmovapd ymmword ptr [edx],ymm1
							
							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr [ebx]												;; x = ymm0		
							vmovapd ymm7,ymm0
							;; ======
							sinh_avx2_macro_pd
							;; ======

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		vmovsd real8 ptr [edx],xmm1   
							jmp short done
			two_left:		vmovsd real8 ptr [edx],xmm1
							movhlps xmm2,xmm1
							vmovsd real8 ptr [edx + 8],xmm2 
							jmp short done
			three_left:		vextractf128 xmm6,ymm1,1	
							movhlps xmm2,xmm1
							vmovsd real8 ptr [edx],xmm1
							vmovsd real8 ptr [edx + 8],xmm2
							vmovsd real8 ptr [edx + 16],xmm6

			done:			vzeroupper
							ret
sinh_avx2_pd				endp


;;	extern "C" bool sinh_avx2_ps(float const *in,int n,float *out);
sinh_avx2_macro_ps			macro
							vminps ymm0,ymm0,ymmword ptr [exp_hi_ps]
							vmaxps ymm0,ymm0,ymmword ptr [exp_lo_ps]
							vmovaps ymm4,ymm0								;; x = ymm4
							vxorps ymm7,ymm7,ymm7
							vcmpltps ymm7,ymm0,ymm7							;; xinf = ymm7
							vandps ymm0,ymm0,ymmword ptr [pos_sign_mask_d]	;; z = ymm0
							vcmpgtps ymm5,ymm0,ymmword ptr [max_log_ps]		;; supmax = ymm5
							vcmpgtps ymm6,ymm0,ymmword ptr [one_ps]			;; zsup = ymm6
							;; exp starts here:
							vmovups ymm1,ymmword ptr [log2e_ps]
							vmulps ymm1,ymm1,ymm0							
							vaddps ymm1,ymm1,ymmword ptr [zero_point_five]  ;; fx = ymm1
							vmovaps ymm2,ymm1								;; tmp = ymm2
							vroundps ymm2,ymm2,00000001b					;; tmp = ymm2
							vcmpgtps ymm3,ymm2,ymm1							;; mask = ymm3
							vandps ymm3,ymm3,ymmword ptr [one_ps]
							vsubps ymm1,ymm2,ymm3
							vmulps ymm2,ymm1,ymmword ptr [c1_ps]			;; tmp = ymm2
							vmulps ymm3,ymm1,ymmword ptr [c2_ps]			;; z = ymm3
							vsubps ymm0,ymm0,ymm2							;; x = ymm0
							vsubps ymm0,ymm0,ymm3							;; x = ymm0
							vmulps ymm3,ymm0,ymm0							;; z = ymm3
							vmovups ymm2,ymmword ptr [m_ecoef_ps]			;; y = ymm2
							vfmadd213ps ymm2,ymm0,ymmword ptr [m_ecoef_ps + 32]
							vfmadd213ps ymm2,ymm0,ymmword ptr [m_ecoef_ps + 64]
							vfmadd213ps ymm2,ymm0,ymmword ptr [m_ecoef_ps + 96]
							vfmadd213ps ymm2,ymm0,ymmword ptr [m_ecoef_ps + 128]
							vfmadd213ps ymm2,ymm0,ymmword ptr [m_ecoef_ps + 160]
							vfmadd213ps ymm2,ymm3,ymm0
							vaddps ymm2,ymm2,ymmword ptr [one_ps]
							
							;; p = 2^k
							vcvttps2dq ymm0,ymm1
							vpaddd ymm0,ymm0,ymmword ptr [int_onetwoseven]
							vpslld ymm0,ymm0,23 							
							vmulps ymm0,ymm0,ymm2							;; z_first_branch = ymm0
							;;exp ends here:
							vmovups ymm1,ymmword ptr [m_zero_point_five]
							vdivps ymm2,ymm1,ymm0
							vfmadd132ps	ymm0,ymm2,ymmword ptr [zero_point_five]
							vxorps ymm2,ymm0,ymmword ptr [neg_sign_mask_d]
							vblendvps ymm0,ymm0,ymm2,ymm7
							vmulps ymm3,ymm4,ymm4
							vmovups ymm2,ymmword ptr [sinh_pcoef_ps]
							vfmadd213ps	ymm2,ymm3,ymmword ptr [sinh_pcoef_ps + 32]
							vfmadd213ps	ymm2,ymm3,ymmword ptr [sinh_pcoef_ps + 64]
							vmulps ymm2,ymm2,ymm3
							vfmadd213ps ymm2,ymm4,ymm4						;; z_sec_branch = ymm2
							vblendvps ymm2,ymm2,ymm0,ymm6
							vblendvps ymm2,ymm2,ymmword ptr [maxnum_ps],ymm5
							vandps ymm3,ymm7,ymm5
							vblendvps ymm2,ymm2,ymmword ptr [min_maxnum_ps],ymm3
							endm

sinh_avx2_ps				proc uses ebx,
									x_ptr:ptr real4,
									n_arg:dword,
									out_ptr:ptr real4

							xor eax,eax

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
							;; =====
							sinh_avx2_macro_ps
							;; =====
							vmovaps ymmword ptr [edx],ymm2					
							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ebx]					;; x = ymm0	
							;; =====
							sinh_avx2_macro_ps
							;; =====

							movaps xmm6,xmm2	
							cmp ecx,4
							jl short rem_left
							vextractf128 xmm6,ymm2,1 
							movaps xmmword ptr [edx],xmm2
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
sinh_avx2_ps				endp
							end
