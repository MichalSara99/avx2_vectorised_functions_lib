include asm_x86_incs/exp_funcs.inc

.code
;;		extern "C" bool exp_avx2_pd(double const* x, int n, double* out);
exp_avx2_pd					proc uses ebx,
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
							vmovupd ymm1,ymmword ptr [log2e_pd]
							vmulpd ymm1,ymm1,ymm0							;; a = ymm1
							vmovapd ymm2,ymm1								;; a = ymm2
							vcmpltpd ymm2,ymm2, ymm7						;; p = ymm2
							vmovupd ymm6,ymmword ptr [one_pd]
							vandpd ymm2,ymm2,ymm6							;; p = ymm2
							vsubpd ymm1,ymm1,ymm2							;; a = ymm1
							vextractf128 xmm3,ymm1,0						;; a_l = xmm3
							vextractf128 xmm4,ymm1,1						;; a_h = xmm4	
							;; this could be macro:
							vsubpd xmm3,xmm3 ,xmmword ptr [opfournine_pd]
							vaddpd xmm3,xmm3,xmmword ptr [long_real]	
							vpsubq xmm3,xmm3,xmmword ptr [long_real]
							vsubpd xmm4,xmm4,xmmword ptr [opfournine_pd]
							vaddpd xmm4,xmm4,xmmword ptr [long_real]				;; k_l = xmm3
							vpsubq xmm4,xmm4,xmmword ptr [long_real]				;; k_h = xmm4
							
							vroundpd ymm1,ymm1,00000001b					;; p = ymm1

							vmovupd ymm5,ymmword ptr [c1_pd]
							vmovupd ymm6,ymmword ptr [c2_pd]
							vmulpd ymm2,ymm1,ymm5							;; a = ymm2
							vsubpd ymm0,ymm0,ymm2							;; x = ymm0
							vmulpd ymm2,ymm1,ymm6							;; a = ymm2
							vsubpd ymm0,ymm0,ymm2							;; x = ymm0
							
							vmovupd ymm5,ymmword ptr [m_ecoef_pd]
							vmovupd ymm6,ymmword ptr [m_ecoef_pd + 32]
							vmulpd ymm2,ymm0,ymm5
							vaddpd ymm2,ymm2,ymm6							;; a = ymm2

							vmovupd ymm5,ymmword ptr [m_ecoef_pd + 64]
							vmovupd ymm6,ymmword ptr [m_ecoef_pd + 96]
							vfmadd213pd ymm2,ymm0,ymm5	
							vfmadd213pd ymm2,ymm0,ymm6						;; a = ymm2

							vmovupd ymm5,ymmword ptr [m_ecoef_pd + 128]
							vmovupd ymm6,ymmword ptr [m_ecoef_pd + 160]
							vfmadd213pd ymm2,ymm0,ymm5	
							vfmadd213pd ymm2,ymm0,ymm6						;; a = ymm2

							vmovupd ymm5,ymmword ptr [m_ecoef_pd + 192]
							vmovupd ymm6,ymmword ptr [m_ecoef_pd + 224]
							vfmadd213pd ymm2,ymm0,ymm5	
							vfmadd213pd ymm2,ymm0,ymm6						;; a = ymm2

							vmovupd ymm5,ymmword ptr [m_ecoef_pd + 256]
							vmovupd ymm6,ymmword ptr [m_ecoef_pd + 288]
							vfmadd213pd ymm2,ymm0,ymm5	
							vfmadd213pd ymm2,ymm0,ymm6						;; a = ymm2

							vmovupd ymm5,ymmword ptr [m_ecoef_pd + 320]
							vmovupd ymm6,ymmword ptr [m_ecoef_pd + 352]
							vfmadd213pd ymm2,ymm0,ymm5	
							vfmadd213pd ymm2,ymm0,ymm6						;; a = ymm2

							;; p = 2^k
							vpaddq xmm3,xmm3, xmmword ptr [int_tentwothree] 
							vpaddq xmm4,xmm4, xmmword ptr [int_tentwothree]
							vinsertf128 ymm3,ymm3,xmm4,1
							vpsllq ymm3,ymm3,52								;; k = ymm3
							vmulpd ymm3,ymm3,ymm2

							vmovapd ymmword ptr [edx],ymm3
							
							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

				done:		ret
exp_avx2_pd					endp


;;		extern "C" bool exp_avx2_ps(float const* x, int n, float* out);
exp_avx2_ps					proc uses ebx,
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

				 @@:		vmovaps ymm0,ymmword ptr [ebx]					;; x = ymm0		
							vminps ymm0,ymm0,ymmword ptr [exp_hi_ps]
							vmaxps ymm0,ymm0,ymmword ptr [exp_lo_ps]
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
							vmulps ymm5,ymm5,ymm4
							vmovaps ymmword ptr [edx],ymm5
							
							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

				done:		ret
exp_avx2_ps					endp
							end