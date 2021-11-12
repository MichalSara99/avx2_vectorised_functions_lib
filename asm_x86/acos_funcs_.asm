include asm_x86_incs/acos_funcs.inc

.code
acos_avx2_macro_pd			macro
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
							vmovapd ymm2,ymm6										;; my_sign = ymm2
	
							vaddpd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd]			;; denom
							vfmadd213pd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd + 32]	
							vfmadd213pd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd + 64]
							vfmadd213pd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd + 96]
							vfmadd213pd ymm6,ymm3,ymmword ptr [asin_qcoefs_pd + 128]
							vdivpd ymm4,ymm4,ymm6
							vfmadd213pd	ymm4, ymm0,ymm0
							endm

;;									ecx,			edx		
;; extern "C" bool acos_avx2_pd(double const *x,double *out, int n);
acos_avx2_pd@@12			proc near
								n_arg		textequ		<[ebp + 8]>
							push ebp
							mov ebp,esp
							push ebx

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


					@@:		vmovapd ymm0,ymmword ptr [ecx]						;; x = ymm0
							vmovupd ymm3,ymmword ptr [op5_pd]
							vcmpgtpd ymm1,ymm0,ymm3								;; init_mask = ymm1
							vmulpd ymm2,ymm0,ymm3
							vsubpd ymm2,ymm3,ymm2
							vsqrtpd ymm2,ymm2									;; xx = ymm2
							vxorpd ymm7,ymm7,ymm7
							vblendvpd ymm6,ymm7,ymmword ptr [one_pd],ymm1		;; my_sign = ymm6
							vblendvpd ymm0,ymm0,ymm2,ymm1						;; x = ymm0
							;; === 

							vcmpltpd ymm7,ymm0,ymm7							;; sign = ymm7
							vandpd ymm0,ymm0,ymmword ptr [pos_sign_mask_q]	;; a = ymm0 = fabs(x)
							
							vcmpgtpd ymm1,ymm0,ymmword ptr [op625_pd]		;; ymm1 = a > 0.625
							;; ====
							acos_avx2_macro_pd
							;; ====
							vblendvpd ymm6,ymm4,ymm5,ymm1							;; final z = ymm5
							;; invert sign of ymm0:
							vxorpd ymm1,ymm5,ymmword ptr [neg_sign_mask_q]
							vblendvpd ymm6,ymm6,ymm1,ymm7

							vmovapd ymm7,ymm2										;; my_sign = ymm7
							vcmpltpd ymm2,ymm0,ymmword ptr [small_pd]				;; ymm2 = a < 1.0e-8
							vblendvpd ymm6,ymm6,ymmword ptr [ecx],ymm2
							vcmpgtpd ymm1,ymm0,ymmword ptr [one_pd]
							vxorpd ymm0,ymm0,ymm0
							vblendvpd ymm6,ymm6,ymm0,ymm1							;; z = ymm6
							;; ===
							vmovupd ymm5,ymmword ptr [one_pd]
							vsubpd ymm4,ymm5,ymm7									;; f_sign = ymm4
							vmulpd ymm3,ymm7,ymmword ptr [three_pd]
							vsubpd ymm3,ymm3,ymm5									;; s_sign = ymm3
							vmulpd ymm2,ymm4,ymmword ptr [pi_o_4_pd]
							vfmadd213pd ymm6,ymm3,ymm2

							vfmadd231pd ymm6,ymm4,ymmword ptr [pmore_bits_pd]	
							vfmadd231pd ymm6,ymm4,ymmword ptr [pi_o_4_pd]

							vmovapd ymmword ptr [edx],ymm6
							add ecx,32
							add edx,32
							dec ebx
							jnz @B


							mov ebx,eax
			too_short:		or ebx,ebx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr [ecx]						;; x = ymm0
							vmovupd ymm3,ymmword ptr [op5_pd]
							vcmpgtpd ymm1,ymm0,ymm3								;; init_mask = ymm1
							vmulpd ymm2,ymm0,ymm3
							vsubpd ymm2,ymm3,ymm2
							vsqrtpd ymm2,ymm2									;; xx = ymm2
							vxorpd ymm7,ymm7,ymm7
							vblendvpd ymm6,ymm7,ymmword ptr [one_pd],ymm1		;; my_sign = ymm6
							vblendvpd ymm0,ymm0,ymm2,ymm1						;; x = ymm0
							;; === 

							vcmpltpd ymm7,ymm0,ymm7							;; sign = ymm7
							vandpd ymm0,ymm0,ymmword ptr [pos_sign_mask_q]	;; a = ymm0 = fabs(x)
							
							vcmpgtpd ymm1,ymm0,ymmword ptr [op625_pd]		;; ymm1 = a > 0.625
							;; =====
							acos_avx2_macro_pd
							;; =====
							vblendvpd ymm6,ymm4,ymm5,ymm1							;; final z = ymm5
							;; invert sign of ymm0:
							vxorpd ymm1,ymm5,ymmword ptr [neg_sign_mask_q]
							vblendvpd ymm6,ymm6,ymm1,ymm7

							vmovapd ymm7,ymm2										;; my_sign = ymm7
							vcmpltpd ymm2,ymm0,ymmword ptr [small_pd]				;; ymm2 = a < 1.0e-8
							vblendvpd ymm6,ymm6,ymmword ptr [ecx],ymm2
							vcmpgtpd ymm1,ymm0,ymmword ptr [one_pd]
							vxorpd ymm0,ymm0,ymm0
							vblendvpd ymm6,ymm6,ymm0,ymm1							;; z = ymm6
							;; ===
							vmovupd ymm5,ymmword ptr [one_pd]
							vsubpd ymm4,ymm5,ymm7									;; f_sign = ymm4
							vmulpd ymm3,ymm7,ymmword ptr [three_pd]
							vsubpd ymm3,ymm3,ymm5									;; s_sign = ymm3
							vmulpd ymm2,ymm4,ymmword ptr [pi_o_4_pd]
							vfmadd213pd ymm6,ymm3,ymm2

							vfmadd231pd ymm6,ymm4,ymmword ptr [pmore_bits_pd]	
							vfmadd231pd ymm6,ymm4,ymmword ptr [pi_o_4_pd]

							cmp ebx,1
							je short one_left
							cmp ebx,2
							je short two_left
							cmp ebx,3
							je short three_left

			one_left:		vmovsd real8 ptr [edx],xmm6   
							jmp short done
			two_left:		vmovsd real8 ptr [edx],xmm6
							movhlps xmm2,xmm6
							vmovsd real8 ptr [edx + 8],xmm2 
							jmp short done
			three_left:		vextractf128 xmm5,ymm6,1	
							movhlps xmm2,xmm6
							vmovsd real8 ptr [edx],xmm6
							vmovsd real8 ptr [edx + 8],xmm2
							vmovsd real8 ptr [edx + 16],xmm5
		
			done:			vzeroupper
							pop ebx
							mov esp,ebp
							pop ebp
							ret 4
acos_avx2_pd@@12			endp

acos_avx2_macro_ps			macro
							vmovaps	ymm6,ymm0
							vcmpltps ymm7,ymm0,ymm7							;; sign = ymm7 = x < 0.0
							vandps ymm0,ymm0,ymmword ptr [pos_sign_mask_d]	;; a = ymm0 = fabs(x)					
							vcmpgtps ymm1,ymm0,ymmword ptr [op5_ps]			;; ymm1 = a > 0.5
							
							;; this is for a > 0.5 case
							vmovups ymm3,ymmword ptr [one_ps]
							vsubps ymm3,ymm3,ymm0							;; zz = ymm3
							vmulps ymm3,ymm3,ymmword ptr [op5_ps]
							vmulps ymm4,ymm0,ymm0
							vblendvps ymm4,	ymm4,ymm3,ymm1					;; z = ymm4
							vsqrtps ymm5,ymm4	
							vblendvps ymm6,ymm0,ymm5,ymm1					;; x = ymm6

							vmovups ymm3,ymmword ptr [acos_coef_ps]
							vfmadd213ps ymm3,ymm4,ymmword ptr [acos_coef_ps + 32]
							vfmadd213ps ymm3,ymm4,ymmword ptr [acos_coef_ps + 64]
							vfmadd213ps ymm3,ymm4,ymmword ptr [acos_coef_ps + 96]
							vfmadd213ps ymm3,ymm4,ymmword ptr [acos_coef_ps + 128]
							vmulps ymm3,ymm3,ymm4
							vfmadd213ps ymm3,ymm6,ymm6						;; z = ymm3

							vaddps ymm4,ymm3,ymm3							;; zz = ymm4
							vmovups ymm5,ymmword ptr [pi_o_2_ps]
							vsubps ymm4,ymm5,ymm4
							vblendvps ymm3,ymm3,ymm4,ymm1

							vmovaps ymm4,ymm2								;; my_sign = ymm4
							vcmpltps ymm2,ymm0,ymmword ptr [small_ps]		;; ymm2 = a < 1.0e-4	
							vblendvps ymm3,ymm3,ymm6,ymm2

							vxorps ymm5, ymm3,ymmword ptr [neg_sign_mask_d]
							vblendvps ymm3,ymm3,ymm5,ymm7
							endm


;;									ecx,		edx,
;; extern "C" bool acos_avx2_ps(float const *x, float *out, int n);
acos_avx2_ps@@12	 		proc near
								n_arg	textequ		<[ebp + 8]>
							push ebp
							mov ebp,esp
							push ebx
							
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
							vmovups ymm1,ymmword ptr [op5_ps]
							vcmpgtps ymm2,ymm0,ymm1							;; init_mask = ymm2
							vmulps ymm3,ymm1,ymm0
							vsubps ymm3,ymm1,ymm3
							vsqrtps ymm3,ymm3								;; xx = ymm3
							vxorps ymm7,ymm7,ymm7
							vblendvps ymm6,ymm7,ymmword ptr [one_ps],ymm2	;; my_sign = ymm6
							vblendvps ymm0,ymm0,ymm3,ymm2					;; x = ymm0
							vmovaps ymm2,ymm6								;; my_sign = ymm6
							;; ========
							acos_avx2_macro_ps
							;; ======
							vmovups ymm1,ymmword ptr [one_ps]
							vsubps ymm2,ymm1,ymm4							;; f_sign = ymm2
							vmulps ymm5,ymm4,ymmword ptr [three_ps]
							vsubps ymm5,ymm5,ymm1							;; s_sign = ymm5
							vmulps ymm6,ymm2,ymmword ptr [pi_o_4_ps]
							vfmadd213ps ymm3,ymm5,ymm6
							vfmadd231ps ymm3,ymm2,ymmword ptr[pi_o_4_ps]	
							vmovaps ymmword ptr [edx],ymm3
							add ecx,32
							add edx,32
							dec ebx
							jnz @B


							mov ebx,eax
			too_short:		or ebx,ebx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ecx]					;; x = ymm0
							vmovups ymm1,ymmword ptr [op5_ps]
							vcmpgtps ymm2,ymm0,ymm1							;; init_mask = ymm2
							vmulps ymm3,ymm1,ymm0
							vsubps ymm3,ymm1,ymm3
							vsqrtps ymm3,ymm3								;; xx = ymm3
							vxorps ymm7,ymm7,ymm7
							vblendvps ymm6,ymm7,ymmword ptr [one_ps],ymm2	;; my_sign = ymm6
							vblendvps ymm0,ymm0,ymm3,ymm2					;; x = ymm0
							vmovaps ymm2,ymm6								;; my_sign = ymm6
							;; ========
							acos_avx2_macro_ps
							;; ======
							vmovups ymm1,ymmword ptr [one_ps]
							vsubps ymm2,ymm1,ymm4							;; f_sign = ymm2
							vmulps ymm5,ymm4,ymmword ptr [three_ps]
							vsubps ymm5,ymm5,ymm1							;; s_sign = ymm5
							vmulps ymm6,ymm2,ymmword ptr [pi_o_4_ps]
							vfmadd213ps ymm3,ymm5,ymm6
							vfmadd231ps ymm3,ymm2,ymmword ptr[pi_o_4_ps]

							movaps xmm6,xmm3	
							cmp ebx,4
							jl short rem_left
							vextractf128 xmm6,ymm3,1 
							movaps xmmword ptr [edx],xmm3
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
	
			done:			vzeroupper
							pop ebx
							mov esp,ebp
							pop ebp
							ret 4
acos_avx2_ps@@12			endp
							end
