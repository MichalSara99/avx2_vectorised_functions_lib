include asm_x86_incs/exp_funcs.inc

.code
exp_avx2_macro_pd			macro
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
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 160]						;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 192]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 224]						;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 256]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 288]						;; a = ymm2
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 320]	
							vfmadd213pd ymm2,ymm0,ymmword ptr [m_ecoef_pd + 352]						;; a = ymm2
							endm
;;										ecx,		edx
;;		extern "C" bool exp_avx2_pd(double const* x,double* out, int n);
exp_avx2_pd@@12				proc near
								n_arg		textequ		<[ebp + 8]>
							push ebp
							mov ebp,esp
							push ebx
	
							xor eax,eax

							test ecx,1fh
							jnz done
							
							test edx,1fh
							jnz done

							mov ebx,n_arg
							cmp ebx,4
							jl too_short

							mov eax,ebx
							and ebx,0fffffffch
							sub eax,ebx
							shr ebx,2

							vxorpd ymm7,ymm7,ymm7

				 @@:		vmovapd ymm0,ymmword ptr [ecx]											;; x = ymm0		
							vmovupd ymm1,ymmword ptr [log2e_pd]
							vmulpd ymm1,ymm1,ymm0													;; a = ymm1
							vmovapd ymm2,ymm1														;; a = ymm2
							vcmpltpd ymm2,ymm2, ymm7												;; p = ymm2
							vandpd ymm2,ymm2,ymmword ptr [one_pd]									;; p = ymm2
							vsubpd ymm1,ymm1,ymm2													;; a = ymm1
							vextractf128 xmm3,ymm1,0												;; a_l = xmm3
							vextractf128 xmm4,ymm1,1												;; a_h = xmm4	
							;; =====
							exp_avx2_macro_pd
							;; =====
							;; p = 2^k
							vpaddq xmm3,xmm3, xmmword ptr [int_tentwothree] 
							vpaddq xmm4,xmm4, xmmword ptr [int_tentwothree]
							vinsertf128 ymm3,ymm3,xmm4,1
							vpsllq ymm3,ymm3,52								;; k = ymm3
							vmulpd ymm3,ymm3,ymm2
							vmovapd ymmword ptr [edx],ymm3						
							add ecx,32
							add edx,32
							dec ebx
							jnz @B

							mov ebx,eax
			too_short:		or ebx,ebx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr [ecx]											;; x = ymm0		
							vmovupd ymm1,ymmword ptr [log2e_pd]
							vmulpd ymm1,ymm1,ymm0													;; a = ymm1
							vmovapd ymm2,ymm1														;; a = ymm2
							vcmpltpd ymm2,ymm2, ymm7												;; p = ymm2
							vandpd ymm2,ymm2,ymmword ptr [one_pd]									;; p = ymm2
							vsubpd ymm1,ymm1,ymm2													;; a = ymm1
							vextractf128 xmm3,ymm1,0												;; a_l = xmm3
							vextractf128 xmm4,ymm1,1												;; a_h = xmm4
							;; =====
							exp_avx2_macro_pd
							;; =====
							;; p = 2^k
							vpaddq xmm3,xmm3, xmmword ptr [int_tentwothree] 
							vpaddq xmm4,xmm4, xmmword ptr [int_tentwothree]
							vinsertf128 ymm3,ymm3,xmm4,1
							vpsllq ymm3,ymm3,52								;; k = ymm3
							vmulpd ymm3,ymm3,ymm2

							cmp ebx,1
							je short one_left
							cmp ebx,2
							je short two_left
							cmp ebx,3
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

				done:		vzeroupper	
							pop ebx
							mov esp,ebp
							pop ebp
							ret 4
exp_avx2_pd@@12				endp


exp_avx2_macro_ps			macro
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
							endm
;;										ecx,		edx
;;		extern "C" bool exp_avx2_ps(float const* x, float* out, int n);
exp_avx2_ps@@12				proc near
								n_arg		textequ		<[ebp + 8]>
							push ebp
							mov ebp,esp
							push ebx
	
							xor eax,eax

							test ecx,1fh
							jnz done
							
							test edx,1fh
							jnz done

							mov ebx,n_arg
							cmp ebx,8
							jl too_short

							mov eax,ebx
							and ebx,0fffffff8h
							sub eax,ebx
							shr ebx,3

				 @@:		vmovaps ymm0,ymmword ptr [ecx]					;; x = ymm0	
							vminps ymm0,ymm0,ymmword ptr [exp_hi_ps]
							vmaxps ymm0,ymm0,ymmword ptr [exp_lo_ps]
							vmovups ymm1,ymmword ptr [log2e_ps]
							;; ======
							exp_avx2_macro_ps
							;; ======
							;; p = 2^k
							vcvttps2dq ymm0,ymm1
							vpaddd ymm0,ymm0,ymmword ptr [int_onetwoseven]
							vpslld ymm0,ymm0,23 							
							vmulps ymm0,ymm0,ymm2
							vmovaps ymmword ptr [edx],ymm0
							
							add ecx,32
							add edx,32
							dec ebx
							jnz @B

							mov ebx,eax
			too_short:		or ebx,ebx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ecx]					;; x = ymm0	
							vminps ymm0,ymm0,ymmword ptr [exp_hi_ps]
							vmaxps ymm0,ymm0,ymmword ptr [exp_lo_ps]
							vmovups ymm1,ymmword ptr [log2e_ps]
							;; ======
							exp_avx2_macro_ps
							;; ======
							;; p = 2^k
							vcvttps2dq ymm0,ymm1
							vpaddd ymm0,ymm0,ymmword ptr [int_onetwoseven]
							vpslld ymm0,ymm0,23 							
							vmulps ymm0,ymm0,ymm2
							
							movaps xmm6,xmm0	
							cmp ebx,4
							jl short rem_left
							vextractf128 xmm6,ymm0,1 
							movaps xmmword ptr [edx],xmm0
							add edx,16
							sub ebx,4
							jz done


			rem_left:		cmp ebx,1
							je short one_left
							cmp ebx,2
							je short two_left
							cmp ebx,3
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

				done:		vzeroupper
							pop ebx
							mov esp,ebp
							pop ebp
							ret 4
exp_avx2_ps@@12				endp
							end