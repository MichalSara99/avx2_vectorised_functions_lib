include asm_x86_incs/tancot_funcs.inc

.code
;;		extern "C" bool tan_avx2_ps(float const* x, int n, float* out);
tan_avx2_macro_ps			macro
							vmovaps ymm1,ymm0								;; sign_bit = xmm1
							vandps ymm0,ymm0,ymmword ptr [int_inv_sign_mask_d]	
							vandps ymm1,ymm1,ymmword ptr [int_sign_mask_d]
							vmovaps ymm2,ymm0
							vmulps ymm2,ymm2,ymmword ptr [cephes_fopi_ps]			;; y = xmm2
							vcvttps2dq ymm3,ymm2  		
							vpaddd ymm3,ymm3,ymmword ptr [int_one_d]
							vpand  ymm3,ymm3,ymmword ptr [int_inv_one_d]
							vcvtdq2ps ymm2,ymm3
														
							vpand ymm3,ymm3,ymmword ptr [int_two_d]
							vpxor ymm7,ymm7,ymm7
							vpcmpeqd  ymm3,ymm3,ymm7								;; poly_msk = xmm3
							vmovups ymm4,ymmword ptr [cephes_dp_ps]
							vmovups ymm5,ymmword ptr [cephes_dp_ps + 32]
							vmovups ymm6,ymmword ptr [cephes_dp_ps + 64]

							vfmadd231ps	ymm0,ymm4,ymm2
							vfmadd231ps	ymm0,ymm5,ymm2
							vfmadd231ps	ymm0,ymm6,ymm2								;; z = xmm0
							
							vmovaps ymm7,ymm0								
							vmulps ymm7,ymm7,ymm7									;; zz = xmm7
							vmovups ymm2,ymmword ptr [tancof_ps]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 32]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 64]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 96]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 128]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 160]
							vmulps ymm2,ymm2,ymm7
							vfmadd213ps ymm2,ymm0,ymm0
							vmovups ymm4,ymmword ptr [one_ps]
							vdivps ymm4,ymm4,ymm2
							vxorps ymm4,ymm4,ymmword ptr [int_sign_mask_d]
							vandps ymm2,ymm2,ymm3
							vandnps ymm3,ymm3,ymm4
							vorps ymm2,ymm2,ymm3
							vxorps ymm2,ymm2,ymm1
							endm

tan_avx2_ps					proc uses ebx,
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

				@@:			vmovaps ymm0,ymmword ptr [ebx]					;; x = xmm0
							;; ======
							tan_avx2_macro_ps
							;; ======
	
							vmovaps ymmword ptr [edx],ymm2
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done


							vmovaps ymm0,ymmword ptr [ebx]					;; x = xmm0
							;; ======
							tan_avx2_macro_ps
							;; ======

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
tan_avx2_ps					endp

;;			extern "C" bool cot_avx2_ps(float const* x, int n, float* out);
cot_avx2_macro_ps			macro
							vmovaps ymm1,ymm0								;; sign_bit = xmm1
							vandps ymm0,ymm0,ymmword ptr [int_inv_sign_mask_d]	
							vandps ymm1,ymm1,ymmword ptr [int_sign_mask_d]
							vmovaps ymm2,ymm0
							vmulps ymm2,ymm2,ymmword ptr [cephes_fopi_ps]			;; y = xmm2
							vcvttps2dq ymm3,ymm2								
							vpaddd ymm3,ymm3,ymmword ptr [int_one_d]
							vpand ymm3,ymm3,ymmword ptr [int_inv_one_d]
							vcvtdq2ps ymm2,ymm3
							vpand ymm3,ymm3,ymmword ptr [int_two_d]
							vpxor ymm7,ymm7,ymm7
							vpcmpeqd ymm3,ymm3,ymm7								;; poly_msk = xmm3
							vmovups ymm4,ymmword ptr [cephes_dp_ps]
							vmovups ymm5,ymmword ptr [cephes_dp_ps + 32]
							vmovups ymm6,ymmword ptr [cephes_dp_ps + 64]
							vfmadd231ps	ymm0,ymm4,ymm2
							vfmadd231ps	ymm0,ymm5,ymm2
							vfmadd231ps	ymm0,ymm6,ymm2						;; z = xmm0
							vmovaps ymm7,ymm0								
							vmulps ymm7,ymm7,ymm7									;; zz = xmm7
							vmovups ymm2,ymmword ptr [tancof_ps]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 32]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 64]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 96]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 128]
							vfmadd213ps ymm2,ymm7,ymmword ptr [tancof_ps + 160]
							vmulps ymm2,ymm2,ymm7
							vfmadd213ps ymm2,ymm0,ymm0
							vmovups ymm4,ymmword ptr [int_sign_mask_d]
							vxorps ymm4,ymm4,ymm2									;; y2 = xmm4
							vmovups ymm5,ymmword ptr [one_ps]
							vdivps ymm5,ymm5,ymm2									;; y = xmm5
							vandps ymm5,ymm5,ymm3
							vandnps ymm3,ymm3,ymm4
							vorps ymm5,ymm5,ymm3
							vxorps ymm5,ymm5,ymm1
							endm

cot_avx2_ps					proc uses ebx,
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

				@@:			vmovaps ymm0,ymmword ptr [ebx]					;; x = xmm0
							;; =======
							cot_avx2_macro_ps
							;; =======
	
							vmovaps ymmword ptr [edx],ymm5
							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovaps ymm0,ymmword ptr [ebx]					;; x = xmm0
							;; =======
							cot_avx2_macro_ps
							;; =======

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

				done:		vzeroupper
							ret
cot_avx2_ps					endp

;;		extern "C" bool tan_avx2_pd(double const* x, int n, double* out);
tan_avx2_macro_pd			macro
							vmovapd ymm1,ymm0								;; sign_bit = xmm1
							vmovdqu	ymm2,ymmword ptr [int_sign_mask_q]
							vandnpd ymm0,ymm2,ymm0
							vandpd ymm1,ymm1,ymmword ptr [int_sign_mask_q]

							vmovupd ymm2,ymmword ptr [cephes_fopi_pd]
							vdivpd ymm3,ymm0,ymm2
							vroundpd ymm3,ymm3,00000001b

							;; check this
							vmulpd ymm2,ymm3,ymmword ptr[c1_od16_pd]
							vroundpd ymm2,ymm2,00000001b
							vmulpd ymm2,ymm2,ymmword ptr[c1_s16_pd]
							vsubpd ymm2,ymm3,ymm2
							vcvttpd2dq xmm2,ymm2 ; j

							vpand xmm4,xmm2,xmmword ptr [mask_1_d]
							vpaddd xmm2,xmm2,xmm4 ; j += 1
							vcvtdq2pd ymm4,xmm4
							vaddpd ymm3,ymm3,ymm4 ; y += 1.0

							vpand xmm4,xmm2,xmmword ptr[mask_2_d]
							vpcmpeqd xmm4,xmm4,xmmword ptr[mask_0_d]
							vpmovsxdq xmm5,xmm4
							vpsrldq xmm4,xmm4,8
							vpmovsxdq xmm6,xmm4
							vmovapd xmm4,xmm5
							vinsertf128 ymm4,ymm4,xmm6,1 ; selection mask 2

							; Extended precision modular arithmetic
							vmulpd ymm5,ymm3,ymmword ptr[cephes_dp_pd]
							vmulpd ymm6,ymm3,ymmword ptr[cephes_dp_pd + 32]
							vmulpd ymm7,ymm3,ymmword ptr[cephes_dp_pd + 64]
							vsubpd ymm0,ymm0,ymm5
							vsubpd ymm0,ymm0,ymm6
							vsubpd ymm0,ymm0,ymm7

							vmulpd ymm5,ymm0,ymm0 ; x^2
							vcmpnlepd ymm6,ymm5,ymmword ptr[prec_pd] ; selection mask 1

							vmovupd ymm2,ymmword ptr [tancof_pd]
							vmulpd ymm2,ymm2,ymm5

							vmovupd ymm3,ymmword ptr [tancof_pd + 32]
							vaddpd ymm2,ymm2,ymm3

							vmulpd ymm2,ymm2,ymm5
							vmovupd ymm3,ymmword ptr [tancof_pd + 64]
							vaddpd ymm2,ymm2,ymm3

							vmovapd ymm7,ymm2
							;;p1elv:
							vmovupd ymm2,ymmword ptr [tancof_pd + 96]
							vaddpd ymm2,ymm2,ymm5
							vmulpd ymm2,ymm2,ymm5
							vmovupd ymm3,ymmword ptr [tancof_pd + 128]
							vaddpd ymm2,ymm2,ymm3

							vmulpd ymm2,ymm2,ymm5
							vmovupd ymm3,ymmword ptr [tancof_pd + 160]
							vaddpd ymm2,ymm2,ymm3

							vmulpd ymm2,ymm2,ymm5
							vmovupd ymm3,ymmword ptr [tancof_pd + 192]
							vaddpd ymm2,ymm2,ymm3

							vdivpd ymm7,ymm7,ymm2
							vmulpd ymm7,ymm7,ymm5
							vmulpd ymm7,ymm7,ymm0
							vaddpd ymm7,ymm7,ymm0

							vandpd ymm7,ymm6,ymm7
							vandnpd ymm0,ymm6,ymm0 ; select according to mask 1
							vaddpd ymm0,ymm7,ymm0

							vmovupd ymm6,ymmword ptr[mone_pd]
							vdivpd ymm7,ymm6,ymm0

							vandpd ymm0,ymm4,ymm0
							vandnpd ymm7,ymm4,ymm7 ; select according to mask 2
							vaddpd ymm0,ymm0,ymm7

							vxorpd ymm0,ymm0,ymm1 ; invert sign
							endm

tan_avx2_pd					proc uses ebx,
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

				@@:			vmovapd ymm0,ymmword ptr [ebx]					;; x = xmm0
							;; =======
							tan_avx2_macro_pd
							;; =======

							vmovapd ymmword ptr [edx],ymm0
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovapd ymm0,ymmword ptr [ebx]					;; x = xmm0
							;; =======
							tan_avx2_macro_pd
							;; =======

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		vmovsd real8 ptr [edx],xmm0   
							jmp short done
			two_left:		vmovsd real8 ptr [edx],xmm0
							movhlps xmm2,xmm0
							vmovsd real8 ptr [edx + 8],xmm2 
							jmp short done
			three_left:		vextractf128 xmm6,ymm0,1	
							movhlps xmm2,xmm0
							vmovsd real8 ptr [edx],xmm0
							vmovsd real8 ptr [edx + 8],xmm2
							vmovsd real8 ptr [edx + 16],xmm6

			done:			vzeroupper
							ret
tan_avx2_pd					endp


;;		extern "C" bool cot_avx2_pd(double const* x, int n, double* out);
cot_avx2_macro_pd			macro
							vmovapd ymm1,ymm0								;; sign_bit = xmm1
							vmovdqu	ymm2,ymmword ptr [int_sign_mask_q]
							vandnpd ymm0,ymm2,ymm0
							vandpd ymm1,ymm1,ymmword ptr [int_sign_mask_q]

							vmovupd ymm2,ymmword ptr [cephes_fopi_pd]
							vdivpd ymm3,ymm0,ymm2
							vroundpd ymm3,ymm3,00000001b

							;; check this
							vmulpd ymm2,ymm3,ymmword ptr[c1_od16_pd]
							vroundpd ymm2,ymm2,00000001b
							vmulpd ymm2,ymm2,ymmword ptr[c1_s16_pd]
							vsubpd ymm2,ymm3,ymm2
							vcvttpd2dq xmm2,ymm2 ; j

							vpand xmm4,xmm2,xmmword ptr [mask_1_d]
							vpaddd xmm2,xmm2,xmm4 ; j += 1
							vcvtdq2pd ymm4,xmm4
							vaddpd ymm3,ymm3,ymm4 ; y += 1.0

							vpand xmm4,xmm2,xmmword ptr[mask_2_d]
							vpcmpeqd xmm4,xmm4,xmmword ptr[mask_0_d]
							vpmovsxdq xmm5,xmm4
							vpsrldq xmm4,xmm4,8
							vpmovsxdq xmm6,xmm4
							vmovapd xmm4,xmm5
							vinsertf128 ymm4,ymm4,xmm6,1 ; selection mask 2

							; Extended precision modular arithmetic
							vmulpd ymm5,ymm3,ymmword ptr[cephes_dp_pd]
							vmulpd ymm6,ymm3,ymmword ptr[cephes_dp_pd + 32]
							vmulpd ymm7,ymm3,ymmword ptr[cephes_dp_pd + 64]
							vsubpd ymm0,ymm0,ymm5
							vsubpd ymm0,ymm0,ymm6
							vsubpd ymm0,ymm0,ymm7

							vmulpd ymm5,ymm0,ymm0 ; x^2
							vcmpnlepd ymm6,ymm5,ymmword ptr[prec_pd] ; selection mask 1

							vmovupd ymm2,ymmword ptr [tancof_pd]
							vmulpd ymm2,ymm2,ymm5

							vmovupd ymm3,ymmword ptr [tancof_pd + 32]
							vaddpd ymm2,ymm2,ymm3

							vmulpd ymm2,ymm2,ymm5
							vmovupd ymm3,ymmword ptr [tancof_pd + 64]
							vaddpd ymm2,ymm2,ymm3

							vmovapd ymm7,ymm2
							;;p1elv:
							vmovupd ymm2,ymmword ptr [tancof_pd + 96]
							vaddpd ymm2,ymm2,ymm5
							vmulpd ymm2,ymm2,ymm5
							vmovupd ymm3,ymmword ptr [tancof_pd + 128]
							vaddpd ymm2,ymm2,ymm3

							vmulpd ymm2,ymm2,ymm5
							vmovupd ymm3,ymmword ptr [tancof_pd + 160]
							vaddpd ymm2,ymm2,ymm3

							vmulpd ymm2,ymm2,ymm5
							vmovupd ymm3,ymmword ptr [tancof_pd + 192]
							vaddpd ymm2,ymm2,ymm3

							vdivpd ymm7,ymm7,ymm2
							vmulpd ymm7,ymm7,ymm5
							vmulpd ymm7,ymm7,ymm0
							vaddpd ymm7,ymm7,ymm0

							vandpd ymm7,ymm6,ymm7
							vandnpd ymm0,ymm6,ymm0 ; select according to mask 1
							vaddpd ymm0,ymm7,ymm0

							vmovupd ymm6,ymmword ptr[mone_pd]
							vdivpd ymm7,ymm6,ymm0

							vandpd ymm0,ymm4,ymm0
							vandnpd ymm7,ymm4,ymm7 ; select according to mask 2
							vaddpd ymm0,ymm0,ymm7

							vxorpd ymm0,ymm0,ymm1 ; invert sign
							vmovupd ymm6,ymmword ptr[one_pd]
							vdivpd ymm0,ymm6,ymm0
							endm

cot_avx2_pd					proc uses ebx,
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

				@@:			vmovapd ymm0,ymmword ptr [ebx]					;; x = xmm0
							;; =======
							cot_avx2_macro_pd
							;; =======

							vmovapd ymmword ptr [edx],ymm0
							add ebx,32
							add edx,32
							dec ecx
							jnz @B


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done


							vmovapd ymm0,ymmword ptr [ebx]					;; x = xmm0
							;; =======
							cot_avx2_macro_pd
							;; =======

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		vmovsd real8 ptr [edx],xmm0   
							jmp short done
			two_left:		vmovsd real8 ptr [edx],xmm0
							movhlps xmm2,xmm0
							vmovsd real8 ptr [edx + 8],xmm2 
							jmp short done
			three_left:		vextractf128 xmm6,ymm0,1	
							movhlps xmm2,xmm0
							vmovsd real8 ptr [edx],xmm0
							vmovsd real8 ptr [edx + 8],xmm2
							vmovsd real8 ptr [edx + 16],xmm6

			done:			vzeroupper
							ret
cot_avx2_pd					endp
							end