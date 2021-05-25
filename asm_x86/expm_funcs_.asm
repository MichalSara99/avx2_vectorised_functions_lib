include asm_x86_incs/expm_funcs.inc

.code
;;		extern "C" bool expm_avx2_ps(float const *in,int size,float *out);
expm_avx2_ps				proc uses ebx,
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

					@@:		vmovaps ymm0,ymmword ptr [ebx]
							vxorps ymm7,ymm7,ymm7
							vcmpgeps ymm7,ymm0,ymm7							;; x_pos_maks = ymm7
							vmovups ymm6,ymmword ptr [pos_sign_mask_d]
							vandps ymm0,ymm0,ymm6							;; x = fabs(x) = ymm0 
							vmovups ymm1,ymmword ptr [one_ps]
							vmovups ymm2,ymmword ptr [expm_coef_ps]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 32]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 64]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 96]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 128]
							vfmadd213ps	ymm2,ymm0,ymm1
							vmulps ymm2,ymm2,ymm2
							vmulps ymm2,ymm2,ymm2
							vdivps ymm2,ymm1,ymm2
							vblendvps ymm3,ymm6,ymm2,ymm7

							vmovaps ymmword ptr[edx],ymm3
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ebx]
							vxorps ymm7,ymm7,ymm7
							vcmpgeps ymm7,ymm0,ymm7							;; x_pos_maks = ymm7
							vmovups ymm6,ymmword ptr [pos_sign_mask_d]
							vandps ymm0,ymm0,ymm6							;; x = fabs(x) = ymm0 
							vmovups ymm1,ymmword ptr [one_ps]
							vmovups ymm2,ymmword ptr [expm_coef_ps]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 32]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 64]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 96]
							vfmadd213ps	ymm2,ymm0,ymmword ptr [expm_coef_ps + 128]
							vfmadd213ps	ymm2,ymm0,ymm1
							vmulps ymm2,ymm2,ymm2
							vmulps ymm2,ymm2,ymm2
							vdivps ymm2,ymm1,ymm2
							vblendvps ymm3,ymm6,ymm2,ymm7

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
expm_avx2_ps				endp

;;		extern "C" bool expm_avx2_pd(double const *in,int size,double *out);
expm_avx2_pd				proc uses ebx,
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

					@@:		vmovapd ymm0,ymmword ptr [ebx]
							vxorpd ymm7,ymm7,ymm7
							vcmpgepd ymm7,ymm0,ymm7							;; x_pos_maks = ymm7
							vmovupd ymm6,ymmword ptr [pos_sign_mask_q]
							vandpd ymm0,ymm0,ymm6							;; x = fabs(x) = ymm0 
							vmovupd ymm1,ymmword ptr [one_pd]
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
							vblendvpd ymm3,ymm6,ymm2,ymm7

							vmovapd ymmword ptr[edx],ymm3
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr [ebx]
							vxorpd ymm7,ymm7,ymm7
							vcmpgepd ymm7,ymm0,ymm7							;; x_pos_maks = ymm7
							vmovupd ymm6,ymmword ptr [pos_sign_mask_q]
							vandpd ymm0,ymm0,ymm6							;; x = fabs(x) = ymm0 
							vmovupd ymm1,ymmword ptr [one_pd]
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
							vblendvpd ymm3,ymm6,ymm2,ymm7

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

				done:		ret
expm_avx2_pd				endp
							end

