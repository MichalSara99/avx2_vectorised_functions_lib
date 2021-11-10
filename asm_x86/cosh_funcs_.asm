include asm_x86_incs/cosh_funcs.inc

.code
;;		extern "C" cosh_avx2_ps(float const *in,int n,float *out);
cosh_avx2_macro_ps			macro
							;; exp from here:
							vmovups ymm1,ymmword ptr [log2e_ps]
							vmulps ymm1,ymm1,ymm0							
							vaddps ymm1,ymm1,ymmword ptr [zero_point_five]  ;; fx = ymm1
							vmovaps ymm2,ymm1								;; tmp = ymm2
							vroundps ymm2,ymm2,00000001b					;; tmp = ymm2
							vcmpgtps ymm7,ymm2,ymm1							;; mask = ymm7
							vandps ymm7,ymm7,ymmword ptr [one_ps]
							vsubps ymm1,ymm2,ymm7
							vmulps ymm2,ymm1,ymmword ptr [c1_ps]			;; tmp = ymm2
							vmulps ymm3,ymm1,ymmword ptr [c2_ps]			;; z = ymm3
							vsubps ymm0,ymm0,ymm2							;; x = ymm0
							vsubps ymm0,ymm0,ymm3							;; x = ymm0
							vmulps ymm3,ymm0,ymm0							;; z = ymm3

							vmovups ymm4,ymmword ptr [m_ecoef_ps]			;; y = ymm4
							vfmadd213ps ymm4,ymm0,ymmword ptr [m_ecoef_ps + 32]
							vfmadd213ps ymm4,ymm0,ymmword ptr [m_ecoef_ps + 64]
							vfmadd213ps ymm4,ymm0,ymmword ptr [m_ecoef_ps + 96]
							vfmadd213ps ymm4,ymm0,ymmword ptr [m_ecoef_ps + 128]
							vfmadd213ps ymm4,ymm0,ymmword ptr [m_ecoef_ps + 160]
							vfmadd213ps ymm4,ymm3,ymm0
							vaddps ymm4,ymm4,ymmword ptr [one_ps]
							
							;; p = 2^k
							vcvttps2dq ymm5,ymm1
							vpaddd ymm5,ymm5,ymmword ptr [int_onetwoseven]
							vpslld ymm5,ymm5,23 							
							vmulps ymm5,ymm5,ymm4							;; ymm5 = exp
							endm

cosh_avx2_ps				proc uses ebx,
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

							vxorpd ymm7,ymm7,ymm7

				 @@:		vmovaps ymm0,ymmword ptr [ebx]						
							vminps ymm0,ymm0,ymmword ptr [exp_hi_ps]
							vmaxps ymm0,ymm0,ymmword ptr [exp_lo_ps]
							vandps ymm0,ymm0,ymmword ptr [pos_sign_mask_d]	;; x = ymm0	
							vcmpgtps ymm6,ymm0,ymmword ptr [max_logf_ps]		;;supmax_mask = ymm6
							;; ====
							cosh_avx2_macro_ps
							;; ====
							;; exp end here:
							vmovups ymm1,ymmword ptr [zero_point_five]
							vdivps ymm2,ymm1,ymm5
							vfmadd213ps	ymm5,ymm1,ymm2
							vblendvps ymm5,ymm5,ymmword ptr [max_num_ps],ymm6
							vmovaps ymmword ptr [edx],ymm5
							
							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ebx]						
							vminps ymm0,ymm0,ymmword ptr [exp_hi_ps]
							vmaxps ymm0,ymm0,ymmword ptr [exp_lo_ps]
							vandps ymm0,ymm0,ymmword ptr [pos_sign_mask_d]	;; x = ymm0	
							vcmpgtps ymm6,ymm0,ymmword ptr [max_logf_ps]		;;supmax_mask = ymm6
							;; ====
							cosh_avx2_macro_ps
							;; ====
							;; exp end here:
							vmovups ymm1,ymmword ptr [zero_point_five]
							vdivps ymm2,ymm1,ymm5
							vfmadd213ps	ymm5,ymm1,ymm2
							vblendvps ymm5,ymm5,ymmword ptr [max_num_ps],ymm6

							movaps xmm6,xmm5	
							cmp ecx,4
							jl short rem_left
							vextractf128 xmm6,ymm5,1 
							movaps xmmword ptr [edx],xmm5
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
cosh_avx2_ps				endp

;;		extern "C" cosh_avx2_pd(double const *in,int n,double *out);
cosh_avx2_macro_pd			macro
							vmulpd ymm7,ymm5,ymmword ptr [one_half_pd]
							vmovupd ymm1,ymmword ptr [one_pd]
							vsubpd ymm7,ymm1,ymm7
							vmulpd ymm0,ymm7,ymm0
					
							;; exp starts here:
							vmovupd ymm1,ymmword ptr [log2e_pd]
							vmulpd ymm1,ymm1,ymm0							;; a = ymm1
							vmovapd ymm2,ymm1								;; a = ymm2
							vxorpd ymm7,ymm7,ymm7
							vcmpltpd ymm2,ymm2,ymm7							;; p = ymm2
							vandpd ymm2,ymm2,ymmword ptr [one_pd]			;; p = ymm2
							vsubpd ymm1,ymm1,ymm2							;; a = ymm1
							vextractf128 xmm3,ymm1,0						;; a_l = xmm3
							vextractf128 xmm4,ymm1,1						;; a_h = xmm4	
							;; this could be macro:
							vsubpd xmm3,xmm3 ,xmmword ptr [opfournine_pd]
							vaddpd xmm3,xmm3,xmmword ptr [long_real]	
							vpsubq xmm3,xmm3,xmmword ptr [long_real]
							vsubpd xmm4,xmm4,xmmword ptr [opfournine_pd]
							vaddpd xmm4,xmm4,xmmword ptr [long_real]								;; k_l = xmm3
							vpsubq xmm4,xmm4,xmmword ptr [long_real]								;; k_h = xmm4
							
							vroundpd ymm1,ymm1,00000001b											;; p = ymm1

							vmulpd ymm2,ymm1,ymmword ptr [c1_pd]									;; a = ymm2
							vsubpd ymm0,ymm0,ymm2													;; x = ymm0
							vmulpd ymm2,ymm1,ymmword ptr [c2_pd]									;; a = ymm2
							vsubpd ymm0,ymm0,ymm2													;; x = ymm0							
							vmulpd ymm2,ymm0,ymmword ptr [m_ecoef_pd]
							vaddpd ymm2,ymm2,ymmword ptr [m_ecoef_pd + 32]							;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 64]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 96]						;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 128]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 160]					;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 192]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 224]					;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 256]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 288]					;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 320]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 352]					;; a = ymm2

							;; p = 2^k
							vpaddq xmm3,xmm3, xmmword ptr [int_tentwothree] 
							vpaddq xmm4,xmm4, xmmword ptr [int_tentwothree]
							vinsertf128 ymm3,ymm3,xmm4,1
							vpsllq ymm3,ymm3,52								;; k = ymm3
							vmulpd ymm3,ymm3,ymm2
							endm

cosh_avx2_pd				proc uses ebx,
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

							vxorpd ymm7,ymm7,ymm7

				 @@:		vmovapd ymm0,ymmword ptr [ebx]					;; x = ymm0	
							vandpd ymm0,ymm0,ymmword ptr[pos_sign_mask_q]
							vmovupd ymm6,ymmword ptr[loge2_pd]
							vaddpd ymm6,ymm6,ymmword ptr [max_log_pd]		;; max = ymm6
							vcmpgtpd ymm6,ymm0,ymm6							;; max_sign = ymm6
							vmovupd ymm5,ymmword ptr[max_log_pd]
							vsubpd ymm5,ymm5,ymmword ptr [loge2_pd]			;; msk = ymm5
							vcmpgepd ymm5,ymm0,ymm5							;; msk_sign = ymm5
							vblendvpd ymm5,ymm7,ymmword ptr [one_pd],ymm5	;; sign_1 = ymm5
							;; =====
							cosh_avx2_macro_pd
							;; =====
							;; exp ends here:
							vsubpd ymm1,ymm3,ymmword ptr [one_pd]									;; tmp_first = ymm1
							vfmadd213pd ymm1,ymm5,ymmword ptr [one_pd]
							vmulpd ymm1,ymm1,ymm3
							vmulpd ymm1,ymm1,ymmword ptr [one_half_pd]
							vmovupd ymm2,ymmword ptr [one_pd]
							vsubpd ymm2,ymm2,ymm5													;; tmp_second = ymm2
							vmovupd ymm4,ymmword ptr [two_pd]
							vmulpd ymm4,ymm3,ymm4													;; two_a = ymm4
							vdivpd ymm2,ymm2,ymm4
							vaddpd ymm3,ymm1,ymm2
							vblendvpd ymm3,ymm3,ymmword ptr [pos_sign_mask_q],ymm6
							vmovapd ymmword ptr [edx],ymm3
							
							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr [ebx]					;; x = ymm0	
							vandpd ymm0,ymm0,ymmword ptr[pos_sign_mask_q]
							vmovupd ymm6,ymmword ptr[loge2_pd]
							vaddpd ymm6,ymm6,ymmword ptr [max_log_pd]		;; max = ymm6
							vcmpgtpd ymm6,ymm0,ymm6							;; max_sign = ymm6
							vmovupd ymm5,ymmword ptr[max_log_pd]
							vsubpd ymm5,ymm5,ymmword ptr [loge2_pd]			;; msk = ymm5
							vcmpgepd ymm5,ymm0,ymm5							;; msk_sign = ymm5
							vblendvpd ymm5,ymm7,ymmword ptr [one_pd],ymm5	;; sign_1 = ymm5
							;; =====
							cosh_avx2_macro_pd
							;; =====
							;; exp ends here:
							vsubpd ymm1,ymm3,ymmword ptr [one_pd]									;; tmp_first = ymm1
							vfmadd213pd ymm1,ymm5,ymmword ptr [one_pd]
							vmulpd ymm1,ymm1,ymm3
							vmulpd ymm1,ymm1,ymmword ptr [one_half_pd]
							vmovupd ymm2,ymmword ptr [one_pd]
							vsubpd ymm2,ymm2,ymm5													;; tmp_second = ymm2
							vmovupd ymm4,ymmword ptr [two_pd]
							vmulpd ymm4,ymm3,ymm4													;; two_a = ymm4
							vdivpd ymm2,ymm2,ymm4
							vaddpd ymm3,ymm1,ymm2
							vblendvpd ymm3,ymm3,ymmword ptr [pos_sign_mask_q],ymm6

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		vmovsd real8 ptr [edx],xmm3   
							jmp short done
			two_left:		vmovsd real8 ptr [edx],xmm3
							movhlps xmm2,xmm3
							vmovsd real8 ptr [edx + 8],xmm2 
							jmp short done
			three_left:		vextractf128 xmm6,ymm3,1	
							movhlps xmm2,xmm3
							vmovsd real8 ptr [edx],xmm3
							vmovsd real8 ptr [edx + 8],xmm2
							vmovsd real8 ptr [edx + 16],xmm6

			done:			vzeroupper
							ret
cosh_avx2_pd				endp
							end