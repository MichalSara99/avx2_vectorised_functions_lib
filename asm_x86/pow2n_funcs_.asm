include asm_x86_incs/pow2n_funcs.inc

.code
;;										ecx,				edx
;;		extern "C" bool pow2n_avx2_pd(long long const *in,double *out,int size);
pow2n_avx2_pd@@12			proc near
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

					@@:		vmovdqa	ymm7,ymmword ptr [ecx]
							vmovdqu	ymm0,ymmword ptr [bias_q]
							vpaddq ymm1,ymm0,ymm7
							vpsllq ymm1,ymm1,52
							vmovapd ymmword ptr [edx],ymm1
							add ecx,32
							add edx,32
							dec ebx
							jnz @B

							mov ebx,eax
			too_short:		or ebx,ebx								
							mov eax,1
							jz done

							vmovdqa	ymm7,ymmword ptr [ecx]
							vmovdqu	ymm0,ymmword ptr [bias_q]
							vpaddq ymm1,ymm0,ymm7
							vpsllq ymm1,ymm1,52

							cmp ebx,1
							je short one_left
							cmp ebx,2
							je short two_left
							cmp ebx,3
							je short three_left

			one_left:		vmovsd real8 ptr [edx],xmm1   
							jmp short done
			two_left:		vmovsd real8 ptr [edx],xmm1
							movhlps xmm2,xmm1
							vmovsd real8 ptr [edx + 8],xmm2 
							jmp short done
			three_left:		vextractf128 xmm5,ymm1,1	
							movhlps xmm2,xmm1
							vmovsd real8 ptr [edx],xmm1
							vmovsd real8 ptr [edx + 8],xmm2
							vmovsd real8 ptr [edx + 16],xmm5

			done:			vzeroupper
							pop ebx
							mov esp,ebp
							pop ebp
							ret 4
pow2n_avx2_pd@@12			endp

;;										ecx,		edx
;;		extern "C" bool pow2n_avx2_ps(int const *in,float *out,int size);
pow2n_avx2_ps@@12			proc near
								n_arg		textequ			<[ebp + 8]>
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

					@@:		vmovdqa	ymm7,ymmword ptr [ecx]
							vmovdqu	ymm0,ymmword ptr [bias_d]
							vpaddd ymm1,ymm0,ymm7
							vpslld ymm1,ymm1,23
							vmovaps ymmword ptr [edx],ymm1
							add ecx,32
							add edx,32
							dec ebx
							jnz @B						


							mov ebx,eax
			too_short:		or ebx,ebx								
							mov eax,1
							jz done

							vmovdqa	ymm7,ymmword ptr [ecx]
							vmovdqu	ymm0,ymmword ptr [bias_d]
							vpaddd ymm1,ymm0,ymm7
							vpslld ymm1,ymm1,23

							movaps xmm6,xmm1	
							cmp ebx,4
							jl short rem_left
							vextractf128 xmm6,ymm1,1 
							movaps xmmword ptr [edx],xmm1
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
pow2n_avx2_ps@@12			endp
							end