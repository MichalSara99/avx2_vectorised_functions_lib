include asm_x86_incs/sincos_funcs.inc
							.code
cos_avx2_macro_ps			macro
							vmovaps ymm3,ymm1
							vdivps ymm3,ymm3,ymmword ptr [two_pi_ps]
							vroundps ymm3,ymm3,0011b
							vmulps ymm3,ymm3,ymmword ptr [two_pi_ps]
							vsubps ymm1,ymm1,ymm3
							vandps ymm1,ymm1,ymmword ptr [absMask_ps]        
							vmovaps ymm2,ymm1						;; xmm2 = x
							vmulps ymm1,ymm1,ymmword ptr [two_o_pi_ps]
							vcvttps2dq ymm3,ymm1
							vpaddw ymm3,ymm3,ymmword ptr [int_one_own]
							vpsrlw ymm3,ymm3,1							;; xmm3
							vcvtdq2ps ymm4,ymm3						;; xmm4 = 0,1,1,2
							vpand ymm3,ymm3,ymmword ptr [int_one_own]
							vcvtdq2ps ymm3,ymm3
							vxorps ymm3,ymm3,ymmword ptr [minusMask_ps] 
							vcvtps2dq ymm3,ymm3
							vpor ymm3,ymm3,ymmword ptr [int_one_own]
							vcvtdq2ps ymm6,ymm3						;; xmm6 = 1,-1

							vmulps ymm4,ymm4,ymmword ptr [pi_ps]
							vsubps ymm4,ymm4,ymm2
							vmovaps ymm1,ymm4

							vmulps ymm1,ymm1,ymm1
							vmovaps ymm2,ymm1
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps]
							vaddps ymm7,ymm7,ymm1
							vmulps ymm1,ymm1,ymm2
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps+32]
							vaddps ymm7,ymm7,ymm1
							vmulps ymm1,ymm1,ymm2
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps+64]
							vaddps ymm7,ymm7,ymm1
							vmulps ymm1,ymm1,ymm2
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps+96]
							vaddps ymm7,ymm7,ymm1
						    vmulps ymm1,ymm1,ymm2
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps+128]
							vaddps ymm7,ymm7,ymm1						
							vmulps ymm7,ymm7,ymm6
							endm
;;										ecx,			edx
;;		extern "C" bool cos_avx2_ps(float const* x,float* out, int n);
cos_avx2_ps@@12				proc near
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

							vxorps ymm7,ymm7,ymm7

					@@:		vmovups ymm7,ymmword ptr [one_ps]
							vmovaps ymm1,ymmword ptr [ecx]
							;; ======
							cos_avx2_macro_ps
							;; ======
							vmovaps ymmword ptr [edx],ymm7
							add ecx,32
							add edx,32
							dec ebx
							jnz @B

							mov ebx,eax
		too_short:			or ebx,ebx
							mov eax,1
							jz done

							vmovups ymm7,ymmword ptr [one_ps]
							vmovaps ymm1,ymmword ptr [ecx]
							;; ======
							cos_avx2_macro_ps
							;; ======

							movaps xmm6,xmm7	
							cmp ebx,4
							jl short rem_left
							vextractf128 xmm6,ymm7,1 
							movaps xmmword ptr [edx],xmm7
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
cos_avx2_ps@@12				endp

cos_avx2_macro_pd			macro
							vmovapd ymm3,ymm1
							vdivpd ymm3,ymm3,ymmword ptr [two_pi_pd]
							vroundpd ymm3,ymm3,0011b
							vmulpd ymm3,ymm3,ymmword ptr [two_pi_pd]
							vsubpd ymm1,ymm1,ymm3
							vandpd ymm1,ymm1,ymmword ptr [absMask_pd]        
							vmovapd ymm2,ymm1						;; xmm2 = x
							vmulpd ymm1,ymm1,ymmword ptr [two_o_pi_pd]
							vcvttpd2dq xmm3,ymm1
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							vcvtdq2pd ymm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							vcvtdq2pd ymm3,xmm3
							vxorpd ymm3,ymm3,ymmword ptr [minusMask_pd] 
							vcvtpd2dq xmm3,ymm3
							vpor xmm3,xmm3,xmmword ptr [int_one]
							vcvtdq2pd ymm6,xmm3						;; xmm6 = 1,-1

							vmulpd ymm4,ymm4,ymmword ptr [pi_pd]
							vsubpd ymm4,ymm4,ymm2
							vmovapd ymm1,ymm4

							vmulpd ymm1,ymm1,ymm1
							vmovapd ymm2,ymm1
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd]
							vaddpd ymm7,ymm7,ymm1
							vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+32]
							vaddpd ymm7,ymm7,ymm1
							vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+64]
							vaddpd ymm7,ymm7,ymm1
							vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+96]
							vaddpd ymm7,ymm7,ymm1
						    vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+128]
							vaddpd ymm7,ymm7,ymm1
							vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+160]
							vaddpd ymm7,ymm7,ymm1							
							vmulpd ymm7,ymm7,ymm6
							endm
;;										ecxm			edx
;;		extern "C" bool cos_avx2_pd(double const* x, double* out, int n);
cos_avx2_pd@@12				proc near
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

					@@:		vmovupd ymm7,ymmword ptr [one_pd]
							vmovapd ymm1,ymmword ptr [ecx]
							;; =====
							cos_avx2_macro_pd
							;; =====
							vmovapd ymmword ptr [edx],ymm7
							add ecx,32
							add edx,32
							dec ebx
							jnz @B

							mov ebx,eax
			too_short:		or ebx,ebx
							mov eax,1
							jz done

							vmovupd ymm7,ymmword ptr [one_pd]
							vmovapd ymm1,ymmword ptr [ecx]
							;; =====
							cos_avx2_macro_pd
							;; =====

							cmp ebx,1
							je short one_left
							cmp ebx,2
							je short two_left
							cmp ebx,3
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

				done:		vzeroupper
							pop ebx
							mov esp,ebp
							pop ebp
							ret 4
cos_avx2_pd@@12				endp


sin_avx2_macro_pd			macro
							vmovupd ymm5,ymmword ptr [half_pi_pd]
							vsubpd ymm5,ymm5,ymm1
							vmovapd ymm3,ymm5
							vdivpd ymm3,ymm3,ymmword ptr [two_pi_pd]
							vroundpd ymm3,ymm3,0011b
							vmulpd ymm3,ymm3,ymmword ptr [two_pi_pd]
							vsubpd ymm5,ymm5,ymm3
							vandpd ymm5,ymm5,ymmword ptr [absMask_pd]        
							vmovapd ymm2,ymm5						;; ymm2 = x
							vmulpd ymm5,ymm5,ymmword ptr [two_o_pi_pd]
							vcvttpd2dq xmm3,ymm5
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; ymm3
							vcvtdq2pd ymm4,xmm3							;; ymm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							vcvtdq2pd ymm3,xmm3
							vxorpd  ymm3,ymm3,ymmword ptr [minusMask_pd] 
							vcvtpd2dq xmm3,ymm3
							vpor  xmm3,xmm3,xmmword ptr [int_one]
							vcvtdq2pd ymm6,xmm3						;; xmm6 = 1,-1

							vmulpd  ymm4,ymm4,ymmword ptr [pi_pd]
							vsubpd ymm4,ymm4,ymm2
							vmovapd ymm1,ymm4

							vmulpd ymm1,ymm1,ymm1
							vmovapd ymm2,ymm1
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd]
							vaddpd ymm7,ymm7,ymm1
							vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+32]
							vaddpd ymm7,ymm7,ymm1
							vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+64]
							vaddpd ymm7,ymm7,ymm1
							vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+96]
							vaddpd ymm7,ymm7,ymm1
						    vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+128]
							vaddpd ymm7,ymm7,ymm1
							vmulpd ymm1,ymm1,ymm2
							vdivpd ymm1,ymm1,ymmword ptr [m_ccoeff_pd+160]
							vaddpd ymm7,ymm7,ymm1							
							vmulpd ymm7,ymm7,ymm6
							endm
;;										ecx,			edx
;;		extern "C" bool sin_avx2_pd(double const* x,double* out, int n);
sin_avx2_pd@@12				proc near
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

					@@:		vmovupd ymm7,ymmword ptr [one_pd]
							vmovapd ymm1,ymmword ptr [ecx]
							;; ======
							sin_avx2_macro_pd
							;; ======
							vmovapd ymmword ptr [edx],ymm7
							add ecx,32
							add edx,32
							dec ebx
							jnz @B

							mov ebx,eax
		too_short:			or ebx,ebx
							mov eax,1
							jz done


							vmovupd ymm7,ymmword ptr [one_pd]
							vmovapd ymm1,ymmword ptr [ecx]
							;; ======
							sin_avx2_macro_pd
							;; ======

							cmp ebx,1
							je short one_left
							cmp ebx,2
							je short two_left
							cmp ebx,3
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

				done:		vzeroupper
							pop ebx
							mov esp,ebp
							pop ebp
							ret 4
sin_avx2_pd@@12				endp


sin_avx2_macro_ps			macro
							vmovups ymm5,ymmword ptr [half_pi_ps]
							vsubps ymm5,ymm5,ymm1
							vmovaps ymm3,ymm5
							vdivps ymm3,ymm3,ymmword ptr [two_pi_ps]
							vroundps ymm3,ymm3,0011b
							vmulps ymm3,ymm3,ymmword ptr [two_pi_ps]
							vsubps ymm5,ymm5,ymm3
							vandps ymm5,ymm5,ymmword ptr [absMask_ps]        
							vmovaps ymm2,ymm5						;; ymm2 = x
							vmulps ymm5,ymm5,ymmword ptr [two_o_pi_ps]
							vcvttps2dq ymm3,ymm5 
							vpaddw ymm3,ymm3, ymmword ptr [int_one_own] 
							vpsrlw ymm3,ymm3,1 							;; xmm3
							vcvtdq2ps ymm4,ymm3							;; ymm4 = 0,1,1,2
							vpand ymm3,ymm3,ymmword ptr [int_one_own] 
							vcvtdq2ps ymm3,ymm3
							vxorps  ymm3,ymm3,ymmword ptr [minusMask_ps] 
							vcvtps2dq ymm3,ymm3
							vpor  ymm3,ymm3, ymmword ptr [int_one_own]
							vcvtdq2ps ymm6,ymm3						;; ymm6 = 1,-1

							vmulps  ymm4,ymm4,ymmword ptr [pi_ps]
							vsubps ymm4,ymm4,ymm2
							vmovaps ymm1,ymm4

							vmulps ymm1,ymm1,ymm1
							vmovaps ymm2,ymm1
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps]
							vaddps ymm7,ymm7,ymm1
							vmulps ymm1,ymm1,ymm2
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps+32]
							vaddps ymm7,ymm7,ymm1
							vmulps ymm1,ymm1,ymm2
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps+64]
							vaddps ymm7,ymm7,ymm1
							vmulps ymm1,ymm1,ymm2
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps+96]
							vaddps ymm7,ymm7,ymm1
						    vmulps ymm1,ymm1,ymm2
							vdivps ymm1,ymm1,ymmword ptr [m_ccoeff_ps+128]
							vaddps ymm7,ymm7,ymm1					
							vmulps ymm7,ymm7,ymm6
							endm
;;										ecx,			edx
;;		extern "C" bool sin_avx2_ps(float const* x,float* out, int n);
sin_avx2_ps@@12				proc near
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
							
							vxorpd ymm7,ymm7,ymm7 

					@@:		vmovups ymm7,ymmword ptr [one_ps]
							vmovaps ymm1,ymmword ptr [ecx]
							;; ======
							sin_avx2_macro_ps
							;; ======
							vmovaps ymmword ptr [edx],ymm7

							add ecx,32
							add edx,32
							dec ebx
							jnz @B

							mov ebx,eax
			too_short:		or ebx,ebx
							mov eax,1
							jz done

							vmovups ymm7,ymmword ptr [one_ps]
							vmovaps ymm1,ymmword ptr [ecx]
							;; ======
							sin_avx2_macro_ps
							;; ======

							movaps xmm6,xmm7	
							cmp ebx,4
							jl short rem_left
							vextractf128 xmm6,ymm7,1 
							movaps xmmword ptr [edx],xmm7
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
sin_avx2_ps@@12				endp
							end
