include asm_x86_incs/log_funcs.inc

.code
;;		extern "C" bool log_avx2_pd(double const* x, int n, double* out);
log_avx2_macro_pd			macro
							vpand ymm6,ymm0,ymmword ptr[qint_twentyfourseven] 
							vpsrlq ymm6,ymm6,52									;; exps64 = ymm6
							vmovdqu ymm5,ymmword ptr[int_sixfourtwozero]		;;  gTo32bitExp = ymm5
							vpermd ymm6,ymm5,ymm6 								;; exps32_sse = ymm6
							vmovapd xmm6,xmm6
							psubd  xmm6,xmmword ptr[int_tentwothree]			;;  normExps = ymm6
							vcvtdq2pd ymm6,xmm6									;; expsPD = ymm6
							vmovupd	ymm7,ymmword ptr[qint_twentyfourseven]
							vandnpd	ymm7,ymm7,ymm0
							vorpd ymm7,ymm7,ymmword ptr [qint_tentwothree]		;; y = ymm7						
							vsubpd ymm1,ymm7,ymmword ptr[one_pd]
							vaddpd ymm2,ymm7,ymmword ptr[one_pd]
							vdivpd ymm1,ymm1,ymm2								;; t = ymm1
							vmulpd ymm2,ymm1,ymm1								;; t2 = ymm2
							vmulpd ymm3,ymm1,ymm2								;; t3 = ymm3

							vmovupd ymm4,ymmword ptr[m_lcoef_pd]
							vfmadd213pd ymm4,ymm3,ymm1							;; term01 = ymm4
							vmulpd ymm1,ymm2,ymm3								;; t5 = ymm1

							vmovupd ymm5,ymmword ptr[m_lcoef_pd + 32]
							vfmadd213pd ymm5,ymm1,ymm4							;; terms012 = ymm5
							vmulpd ymm3,ymm1,ymm2								;; t7 = ymm3

							vmovupd ymm4,ymmword ptr[m_lcoef_pd + 64]
							vfmadd213pd ymm4,ymm3,ymm5							;; terms0123 = ymm4
							vmulpd ymm3,ymm3,ymm2								;; t9 = ymm3

							vmovupd ymm5,ymmword ptr[m_lcoef_pd + 96]
							vfmadd213pd ymm5,ymm3,ymm4							;; terms01234 = ymm5
							vmulpd ymm3,ymm5,ymmword ptr [sqrthf_pd]			;; log2_y = ymm3
							vaddpd ymm3,ymm3,ymm6								;; log2_x = ymm3
							vdivpd ymm3,ymm3,ymmword ptr[log_q_pd]
							endm

log_avx2_pd					proc uses ebx,
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

					@@:		vmovapd ymm0,ymmword ptr[ebx]
							;; =====
							log_avx2_macro_pd
							;; =====
							vmovapd ymmword ptr [edx],ymm3

							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr[ebx]
							;; =====
							log_avx2_macro_pd
							;; =====

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
log_avx2_pd					endp

;;		extern "C" bool log_avx2_ps(float const* x, int n, float* out);
log_avx2_macro_ps			macro
							vcmpleps ymm1,ymm0,ymm7							; invalid_mask = ymm1
							vmaxps ymm0,ymm0,ymmword ptr [int_min_norm]	
							vpsrld ymm2, ymm0,23							; imm0 = ymm2
							vmovups ymm7,ymmword ptr [int_mantisa]
							vandnps ymm0,ymm7,ymm0	
							vorps ymm0,ymm0,ymmword ptr [one_half_ps]
							vpsubd ymm2,ymm2,ymmword ptr [int_onetwoseven]
							vcvtdq2ps ymm3,ymm2								; e = ymm3
							vaddps ymm3,ymm3,ymmword ptr [one_ps]
							vcmpltps ymm4,ymm0,ymmword ptr [sqrthf_ps]		; mask = ymm4
							vandps ymm5,ymm0,ymm4							; tmp = ymm5
							vsubps ymm0,ymm0,ymmword ptr [one_ps]
							vandps ymm6,ymm4,ymmword ptr [one_ps]
							vsubps ymm3,ymm3,ymm6
							vaddps ymm0,ymm0,ymm5
							vmulps ymm6,ymm0,ymm0							; z = ymm6
							vmovups ymm7,ymmword ptr [m_lcoef_ps]			; y = ymm7
							vfmadd213ps ymm7,ymm0,ymmword ptr [m_lcoef_ps + 32]
							vfmadd213ps ymm7,ymm0,ymmword ptr [m_lcoef_ps + 64]
							vfmadd213ps ymm7,ymm0,ymmword ptr [m_lcoef_ps + 96]
							vfmadd213ps ymm7,ymm0,ymmword ptr [m_lcoef_ps + 128]
							vfmadd213ps ymm7,ymm0,ymmword ptr [m_lcoef_ps + 160]
							vfmadd213ps ymm7,ymm0,ymmword ptr [m_lcoef_ps + 192]
							vfmadd213ps ymm7,ymm0,ymmword ptr [m_lcoef_ps + 224]
							vfmadd213ps ymm7,ymm0,ymmword ptr [m_lcoef_ps + 256]
							vmulps ymm7,ymm7,ymm0
							vmulps ymm7,ymm7,ymm6 
							vmulps ymm5,ymm3,ymmword ptr [log_q1_ps]
							vaddps ymm7,ymm7,ymm5
							vmulps ymm5,ymm6,ymmword ptr [one_half_ps]
							vsubps ymm7,ymm7,ymm5
							vmulps ymm5,ymm3,ymmword ptr [log_q2_ps]
							vaddps ymm0,ymm0,ymm7
							vaddps ymm0,ymm0,ymm5
							vorps ymm0,ymm0,ymm1
							endm

log_avx2_ps					proc uses ebx,
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


					@@:		vxorpd ymm7,ymm7,ymm7
							vmovapd ymm0,ymmword ptr [ebx]					; x = ymm0
							;; =====
							log_avx2_macro_ps
							;; =====
							vmovaps ymmword ptr [edx],ymm0

							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vxorpd ymm7,ymm7,ymm7
							vmovapd ymm0,ymmword ptr [ebx]					; x = ymm0
							;; =====
							log_avx2_macro_ps
							;; =====

							movaps xmm6,xmm0	
							cmp ecx,4
							jl short rem_left
							vextractf128 xmm6,ymm0,1 
							movaps xmmword ptr [edx],xmm0
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
log_avx2_ps					endp
							end