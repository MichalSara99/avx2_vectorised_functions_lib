include asm_x86_incs/expint_funcs.inc

.code
;;		extern "C" bool expint_avx2_ps(float const *in,int size,float *out);
expint_avx2_ps				proc uses ebx,
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


					@@:		vmovaps ymm0,ymmword ptr [ebx]					; x = ymm0
							vxorps ymm7,ymm7,ymm7
							vcmpleps ymm1,ymm0,ymm7							; invalid_mask = ymm1
							vandps ymm0,ymm0,ymmword ptr [pos_sign_mask_d]	
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
							vorps ymm3,ymm0,ymm1								;; ymm3 = log
							;;exp ends here
							vmovaps ymm0,ymmword ptr [ebx]
							vxorps ymm7,ymm7,ymm7
							vcmpltps ymm5,ymm0,ymm7							;; x_mask = ymm5
							vcmpgeps ymm7,ymm0,ymm7							;; x_pos_maks = ymm7
							vmovups ymm6,ymmword ptr [pos_sign_mask_d]
							vandps ymm0,ymm0,ymm6							;; x = fabs(x) = ymm0 
							vmovups ymm1,ymmword ptr [one_ps]
							vcmpleps ymm4,ymm0,ymm1							;; ymm4 = x_one
							vmovups ymm2,ymmword ptr [expm_coef_ps]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 32]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 64]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 96]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 128]
							vfmadd213ps	ymm2,ymm0,ymm1
							vmulps ymm2,ymm2,ymm2
							vmulps ymm2,ymm2,ymm2
							vdivps ymm2,ymm1,ymm2
							vblendvps ymm2,ymm6,ymm2,ymm7					;; ymm2 = expm
							
							vmovups ymm1,ymmword ptr [expint_afcoef_ps]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 32]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 64]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 96]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 128]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 160]
							vsubps ymm1,ymm1,ymm3								;; t = ymm1

							vmovups ymm3,ymmword ptr [one_ps]
							vfmadd213ps	ymm3,ymm0,ymmword ptr [expint_ascoef_ps]
							vfmadd213ps	ymm3,ymm0,ymmword ptr [expint_ascoef_ps + 32]
							vfmadd213ps	ymm3,ymm0,ymmword ptr [expint_ascoef_ps + 64]
							vfmadd213ps	ymm3,ymm0,ymmword ptr [expint_ascoef_ps + 96]	;; p = ymm3

							vmovups ymm6,ymmword ptr [one_ps]
							vfmadd213ps	ymm6,ymm0,ymmword ptr [expint_bscoef_ps]
							vfmadd213ps	ymm6,ymm0,ymmword ptr [expint_bscoef_ps + 32]
							vfmadd213ps	ymm6,ymm0,ymmword ptr [expint_bscoef_ps + 64]
							vfmadd213ps	ymm6,ymm0,ymmword ptr [expint_bscoef_ps + 96]	;; q = ymm6
							vdivps ymm3,ymm3,ymm6
							vmulps ymm3,ymm3,ymm2										;; s = ymm3
							vdivps ymm3,ymm3,ymm0
							vblendvps ymm3,ymm3,ymm1,ymm4
							vmovaps ymmword ptr [edx],ymm3

							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ebx]					; x = ymm0
							vxorps ymm7,ymm7,ymm7
							vcmpleps ymm1,ymm0,ymm7							; invalid_mask = ymm1
							vandps ymm0,ymm0,ymmword ptr [pos_sign_mask_d]	
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
							vorps ymm3,ymm0,ymm1								;; ymm3 = log
							;;exp ends here
							vmovaps ymm0,ymmword ptr [ebx]
							vxorps ymm7,ymm7,ymm7
							vcmpltps ymm5,ymm0,ymm7							;; x_mask = ymm5
							vcmpgeps ymm7,ymm0,ymm7							;; x_pos_maks = ymm7
							vmovups ymm6,ymmword ptr [pos_sign_mask_d]
							vandps ymm0,ymm0,ymm6							;; x = fabs(x) = ymm0 
							vmovups ymm1,ymmword ptr [one_ps]
							vcmpleps ymm4,ymm0,ymm1							;; ymm4 = x_one
							vmovups ymm2,ymmword ptr [expm_coef_ps]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 32]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 64]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 96]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 128]
							vfmadd213ps	ymm2,ymm0,ymm1
							vmulps ymm2,ymm2,ymm2
							vmulps ymm2,ymm2,ymm2
							vdivps ymm2,ymm1,ymm2
							vblendvps ymm2,ymm6,ymm2,ymm7					;; ymm2 = expm
							
							vmovups ymm1,ymmword ptr [expint_afcoef_ps]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 32]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 64]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 96]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 128]
							vfmadd213ps	ymm1,ymm0,ymmword ptr [expint_afcoef_ps + 160]
							vsubps ymm1,ymm1,ymm3								;; t = ymm1

							vmovups ymm3,ymmword ptr [one_ps]
							vfmadd213ps	ymm3,ymm0,ymmword ptr [expint_ascoef_ps]
							vfmadd213ps	ymm3,ymm0,ymmword ptr [expint_ascoef_ps + 32]
							vfmadd213ps	ymm3,ymm0,ymmword ptr [expint_ascoef_ps + 64]
							vfmadd213ps	ymm3,ymm0,ymmword ptr [expint_ascoef_ps + 96]	;; p = ymm3

							vmovups ymm6,ymmword ptr [one_ps]
							vfmadd213ps	ymm6,ymm0,ymmword ptr [expint_bscoef_ps]
							vfmadd213ps	ymm6,ymm0,ymmword ptr [expint_bscoef_ps + 32]
							vfmadd213ps	ymm6,ymm0,ymmword ptr [expint_bscoef_ps + 64]
							vfmadd213ps	ymm6,ymm0,ymmword ptr [expint_bscoef_ps + 96]	;; q = ymm6
							vdivps ymm3,ymm3,ymm6
							vmulps ymm3,ymm3,ymm2										;; s = ymm3
							vdivps ymm3,ymm3,ymm0
							vblendvps ymm3,ymm3,ymm1,ymm4

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

				done:		ret
expint_avx2_ps				endp

;;		extern "C" bool expint_avx2_pd(double const *in,int size,double *out);
expint_avx2_pd				proc uses ebx,
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
							vxorpd ymm7,ymm7,ymm7
							vcmplepd ymm7,ymm0,ymm7								;; inv_mask = ymm7
							vandpd ymm0,ymm0,ymmword ptr[pos_sign_mask_q]
							;; here starts log:
							vpand ymm6,ymm0,ymmword ptr[qint_twentyfourseven] 
							vpsrlq ymm6,ymm6,52									;; exps64 = ymm6
							vmovdqu ymm5,ymmword ptr[int_sixfourtwozero]		;;  gTo32bitExp = ymm5
							vpermd ymm6,ymm5,ymm6 								;; exps32_sse = ymm6
							vmovapd xmm6,xmm6
							psubd  xmm6,xmmword ptr[int_tentwothree]			;;  normExps = ymm6
							vcvtdq2pd ymm6,xmm6									;; expsPD = ymm6
							vmovupd	ymm5,ymmword ptr[qint_twentyfourseven]
							vandnpd	ymm5,ymm5,ymm0
							vorpd ymm5,ymm5,ymmword ptr [qint_tentwothree]		;; y = ymm5						
							vsubpd ymm1,ymm5,ymmword ptr[one_pd]
							vaddpd ymm2,ymm5,ymmword ptr[one_pd]
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
							vorpd ymm3,ymm3,ymm7								;; log = ymm3
							;; here ends log:
							
							;; expm starts here:
							vmovapd ymm0,ymmword ptr[ebx]
							vxorpd ymm7,ymm7,ymm7
							vcmpltpd ymm5,ymm0,ymm7								;; x_mask = ymm5
							vcmpgepd ymm7,ymm0,ymm7								;; x_pos_maks = ymm7
							vmovupd ymm6,ymmword ptr [pos_sign_mask_q]
							vandpd ymm0,ymm0,ymm6								;; x = fabs(x) = ymm0
							vmovupd ymm1,ymmword ptr [one_pd]
							vcmplepd ymm4,ymm0,ymm1								;; x_one = ymm4
							vmovupd ymm2,ymmword ptr [expm_coef_pd]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 32]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 64]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 96]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 128]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 160]
							vfmadd213pd	ymm2,ymm0,ymm1
							vmulpd ymm2,ymm2,ymm2
							vmulpd ymm2,ymm2,ymm2
							vdivpd ymm2,ymm1,ymm2
							vblendvpd ymm2,ymm6,ymm2,ymm7						;; expm = ymm2
							;; expm ends here:

							vmovupd ymm1,ymmword ptr [expint_afcoef_pd]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 32]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 64]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 96]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 128]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 160]
							vsubpd ymm1,ymm1,ymm3								;; t = ymm1

							vmovupd ymm3,ymmword ptr [one_pd]
							vfmadd213pd	ymm3,ymm0,ymmword ptr [expint_ascoef_pd]
							vfmadd213pd	ymm3,ymm0,ymmword ptr [expint_ascoef_pd + 32]
							vfmadd213pd	ymm3,ymm0,ymmword ptr [expint_ascoef_pd + 64]
							vfmadd213pd	ymm3,ymm0,ymmword ptr [expint_ascoef_pd + 96]	;; p = ymm3

							vmovupd ymm6,ymmword ptr [one_pd]
							vfmadd213pd	ymm6,ymm0,ymmword ptr [expint_bscoef_pd]
							vfmadd213pd	ymm6,ymm0,ymmword ptr [expint_bscoef_pd + 32]
							vfmadd213pd	ymm6,ymm0,ymmword ptr [expint_bscoef_pd + 64]
							vfmadd213pd	ymm6,ymm0,ymmword ptr [expint_bscoef_pd + 96]	;; q = ymm6
							vdivpd ymm3,ymm3,ymm6
							vmulpd ymm3,ymm3,ymm2										;; s = ymm3
							vdivpd ymm3,ymm3,ymm0					

							vblendvpd ymm3,ymm3,ymm1,ymm4
							vblendvpd ymm3,ymm3,ymmword ptr [pos_sign_mask_q],ymm5
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
							vxorpd ymm7,ymm7,ymm7
							vcmplepd ymm7,ymm0,ymm7								;; inv_mask = ymm7
							vandpd ymm0,ymm0,ymmword ptr[pos_sign_mask_q]
							;; here starts log:
							vpand ymm6,ymm0,ymmword ptr[qint_twentyfourseven] 
							vpsrlq ymm6,ymm6,52									;; exps64 = ymm6
							vmovdqu ymm5,ymmword ptr[int_sixfourtwozero]		;;  gTo32bitExp = ymm5
							vpermd ymm6,ymm5,ymm6 								;; exps32_sse = ymm6
							vmovapd xmm6,xmm6
							psubd  xmm6,xmmword ptr[int_tentwothree]			;;  normExps = ymm6
							vcvtdq2pd ymm6,xmm6									;; expsPD = ymm6
							vmovupd	ymm5,ymmword ptr[qint_twentyfourseven]
							vandnpd	ymm5,ymm5,ymm0
							vorpd ymm5,ymm5,ymmword ptr [qint_tentwothree]		;; y = ymm5						
							vsubpd ymm1,ymm5,ymmword ptr[one_pd]
							vaddpd ymm2,ymm5,ymmword ptr[one_pd]
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
							vorpd ymm3,ymm3,ymm7								;; log = ymm3
							;; here ends log:
							
							;; expm starts here:
							vmovapd ymm0,ymmword ptr[ebx]
							vxorpd ymm7,ymm7,ymm7
							vcmpltpd ymm5,ymm0,ymm7								;; x_mask = ymm5
							vcmpgepd ymm7,ymm0,ymm7								;; x_pos_maks = ymm7
							vmovupd ymm6,ymmword ptr [pos_sign_mask_q]
							vandpd ymm0,ymm0,ymm6								;; x = fabs(x) = ymm0
							vmovupd ymm1,ymmword ptr [one_pd]
							vcmplepd ymm4,ymm0,ymm1								;; x_one = ymm4
							vmovupd ymm2,ymmword ptr [expm_coef_pd]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 32]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 64]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 96]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 128]
							vfmadd213pd	ymm2,ymm0,ymmword ptr [expm_coef_pd + 160]
							vfmadd213pd	ymm2,ymm0,ymm1
							vmulpd ymm2,ymm2,ymm2
							vmulpd ymm2,ymm2,ymm2
							vdivpd ymm2,ymm1,ymm2
							vblendvpd ymm2,ymm6,ymm2,ymm7						;; expm = ymm2
							;; expm ends here:

							vmovupd ymm1,ymmword ptr [expint_afcoef_pd]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 32]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 64]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 96]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 128]
							vfmadd213pd	ymm1,ymm0,ymmword ptr [expint_afcoef_pd + 160]
							vsubpd ymm1,ymm1,ymm3								;; t = ymm1

							vmovupd ymm3,ymmword ptr [one_pd]
							vfmadd213pd	ymm3,ymm0,ymmword ptr [expint_ascoef_pd]
							vfmadd213pd	ymm3,ymm0,ymmword ptr [expint_ascoef_pd + 32]
							vfmadd213pd	ymm3,ymm0,ymmword ptr [expint_ascoef_pd + 64]
							vfmadd213pd	ymm3,ymm0,ymmword ptr [expint_ascoef_pd + 96]	;; p = ymm3

							vmovupd ymm6,ymmword ptr [one_pd]
							vfmadd213pd	ymm6,ymm0,ymmword ptr [expint_bscoef_pd]
							vfmadd213pd	ymm6,ymm0,ymmword ptr [expint_bscoef_pd + 32]
							vfmadd213pd	ymm6,ymm0,ymmword ptr [expint_bscoef_pd + 64]
							vfmadd213pd	ymm6,ymm0,ymmword ptr [expint_bscoef_pd + 96]	;; q = ymm6
							vdivpd ymm3,ymm3,ymm6
							vmulpd ymm3,ymm3,ymm2										;; s = ymm3
							vdivpd ymm3,ymm3,ymm0					

							vblendvpd ymm3,ymm3,ymm1,ymm4
							vblendvpd ymm6,ymm3,ymmword ptr [pos_sign_mask_q],ymm5

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
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

			done:			ret
expint_avx2_pd				endp
							end
