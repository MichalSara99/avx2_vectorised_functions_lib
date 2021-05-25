include asm_x86_incs/pow2n_funcs.inc

.code
;;		extern "C" bool pow2n_avx2_pd(long long const *in,int size,double *out);
pow2n_avx2_pd				proc uses ebx,
									n_ptr:ptr qword,
									n_arg:dword,
									out_ptr:ptr real8
							
							xor eax,eax

							mov ebx,n_ptr
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

					@@:		vmovdqa	ymm7,ymmword ptr [ebx]
							vmovdqu	ymm0,ymmword ptr [bias_q]
							vpaddq ymm1,ymm0,ymm7
							vpsllq ymm1,ymm1,52
							vmovapd ymmword ptr [edx],ymm1
							add ebx,32
							add edx,32
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovdqa	ymm7,ymmword ptr [ebx]
							vmovdqu	ymm0,ymmword ptr [bias_q]
							vpaddq ymm1,ymm0,ymm7
							vpsllq ymm1,ymm1,52

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
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


			done:			ret
pow2n_avx2_pd				endp

;;		extern "C" bool pow2n_avx2_ps(int const *in,int size,float *out);
pow2n_avx2_ps				proc uses ebx,
									n_ptr:ptr dword,
									n_arg:dword,
									out_ptr:ptr real4

							xor eax,eax

							mov ebx,n_ptr
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

					@@:		vmovdqa	ymm7,ymmword ptr [ebx]
							vmovdqu	ymm0,ymmword ptr [bias_d]
							vpaddd ymm1,ymm0,ymm7
							vpslld ymm1,ymm1,23
							vmovaps ymmword ptr [edx],ymm1
							add ebx,32
							add edx,32
							dec ecx
							jnz @B						


							mov ecx,eax
			too_short:		or ecx,ecx								
							mov eax,1
							jz done

							vmovdqa	ymm7,ymmword ptr [ebx]
							vmovdqu	ymm0,ymmword ptr [bias_d]
							vpaddd ymm1,ymm0,ymm7
							vpslld ymm1,ymm1,23

							movaps xmm6,xmm1	
							cmp ecx,4
							jl short rem_left
							vextractf128 xmm6,ymm1,1 
							movaps xmmword ptr [edx],xmm1
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
pow2n_avx2_ps				endp
							end