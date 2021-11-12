include asm_x86_incs/basic_operations.inc

.code
;;							ecx,							edx
;;		bool add_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
;;					     float *out_aligned_32,int n);
add_avx2_ps@@16		proc near
						out_ptr		textequ			<[ebp + 8]>
						n_arg		textequ			<[ebp + 12]>
					push ebp
					mov ebp,esp
					push ebx
					push edi

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					mov edi,out_ptr
					test edx,1fh
					jnz done

					mov ebx,n_arg
					cmp ebx,8
					jl too_short

					mov eax,ebx
					and ebx,0fffffff8h
					sub eax,ebx
					shr ebx,3

			@@:		vmovaps ymm0,ymmword ptr [ecx]
					vaddps ymm3,ymm0,ymmword ptr [edx]
					vmovaps ymmword ptr [edi],ymm3
					add ecx,32
					add edx,32
					add edi,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [ecx]
					vaddps ymm3,ymm0,ymmword ptr [edx]

					movaps xmm6,xmm3	
					cmp ebx,4
					jl short rem_left
					vextractf128 xmm6,ymm3,1 
					movaps xmmword ptr [edi],xmm3
					add edi,16
					sub ebx,4
					jz done

	rem_left:		cmp ebx,1
					je short one_left
					cmp ebx,2
					je short two_left
					cmp ebx,3
					je short three_left

	one_left:		movss real4 ptr [edi],xmm6
					jmp short done
	two_left:		insertps xmm2,xmm6,01000000b
					movss real4 ptr [edi],xmm6
					movss real4 ptr [edi + 4],xmm2	
					jmp short done
	three_left:		insertps xmm2,xmm6,01000000b
					insertps xmm4,xmm6,10000000b
					movss real4 ptr [edi],xmm6
					movss real4 ptr [edi + 4],xmm2
					movss real4 ptr [edi + 8],xmm4

			done:	vzeroupper	
					pop edi
					pop ebx
					mov esp,ebp
					pop ebp
					ret	8
add_avx2_ps@@16		endp

;;								ecx,						edx		
;;		 bool add_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
;;						double *out_aligned_32,int n);
add_avx2_pd@@16		proc near
						out_ptr		textequ			<[ebp + 8]>
						n_arg		textequ			<[ebp + 12]>
					push ebp
					mov ebp,esp
					push ebx
					push edi					

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					mov edi,out_ptr
					test edi,1fh
					jnz done

					mov ebx,n_arg
					cmp ebx,4
					jl too_short

					mov eax,ebx
					and ebx,0fffffffch
					sub eax,ebx
					shr ebx,2

			@@:		vmovapd ymm0,ymmword ptr [ecx]
					vaddpd ymm7,ymm0,ymmword ptr [edx]
					vmovapd ymmword ptr [edi],ymm7
					add ecx,32
					add edx,32
					add edi,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [ecx]
					vaddpd ymm7,ymm0,ymmword ptr [edx]

					cmp ebx,1
					je short one_left
					cmp ebx,2
					je short two_left
					cmp ebx,3
					je short three_left

	one_left:		vmovsd real8 ptr [edi],xmm7   
					jmp short done
	two_left:		vmovsd real8 ptr [edi],xmm7
					movhlps xmm2,xmm7
					vmovsd real8 ptr [edi + 8],xmm2 
					jmp short done
	three_left:		vextractf128 xmm6,ymm7,1	
					movhlps xmm2,xmm7
					vmovsd real8 ptr [edi],xmm7
					vmovsd real8 ptr [edi + 8],xmm2
					vmovsd real8 ptr [edi + 16],xmm6

		done:		vzeroupper	
					pop edi
					pop ebx
					mov esp,ebp
					pop ebp
					ret 8
add_avx2_pd@@16		endp

;;									ecx,						xmm0							
;;		bool add_broad_avx2_ps(float const *in1_aligned_32, float const in2,
;;									edx			
;;							float *out_aligned_32,int n);
add_broad_avx2_ps@@16	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx
							
						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done	

						vbroadcastss ymm6, xmm0 

						mov ebx,n_arg
						cmp ebx,8
						jl too_short

						mov eax,ebx
						and ebx,0fffffff8h
						sub eax,ebx
						shr ebx,3

				@@:		vmovaps ymm0,ymmword ptr [ecx]
						vaddps ymm3,ymm0,ymm6
						vmovaps ymmword ptr [edx],ymm3
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovaps ymm0,ymmword ptr [ecx]
						vaddps ymm3,ymm0,ymm6

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

				done:	vzeroupper	
						pop ebx
						mov esp,ebp
						pop ebp
						ret	4
add_broad_avx2_ps@@16	endp

;;									ecx,						xmm0
;;		 bool add_broad_avx2_pd(double const *in1_aligned_32, double const in2,
;;									edx
;;							double *out_aligned_32,int n);
add_broad_avx2_pd@@20	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastsd ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,4
						jl too_short

						mov eax,ebx
						and ebx,0fffffffch
						sub eax,ebx
						shr ebx,2

				@@:		vmovapd ymm0,ymmword ptr [ecx]
						vaddpd ymm7,ymm0,ymm6
						vmovapd ymmword ptr [edx],ymm7
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovapd ymm0,ymmword ptr [ecx]
						vaddpd ymm7,ymm0,ymm6

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
add_broad_avx2_pd@@20	endp

;;							ecx,							edx
;;		bool sub_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
;;						float *out_aligned_32,int n);
sub_avx2_ps@@16		proc near
						out_ptr		textequ		<[ebp + 8]>
						n_arg		textequ		<[ebp + 12]>
					push ebp
					mov ebp,esp
					push ebx
					push edi
					
					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					mov edi,out_ptr
					test edi,1fh
					jnz done

					mov ebx,n_arg
					cmp ebx,8
					jl too_short

					mov eax,ebx
					and ebx,0fffffff8h
					sub eax,ebx
					shr ebx,3

			@@:		vmovaps ymm0,ymmword ptr [ecx]
					vsubps ymm3,ymm0,ymmword ptr [edx]
					vmovaps ymmword ptr [edi],ymm3
					add ecx,32
					add edx,32
					add edi,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [ecx]
					vsubps ymm3,ymm0,ymmword ptr [edx]

					movaps xmm6,xmm3	
					cmp ebx,4
					jl short rem_left
					vextractf128 xmm6,ymm3,1 
					movaps xmmword ptr [edi],xmm3
					add edi,16
					sub ebx,4
					jz done

	rem_left:		cmp ebx,1
					je short one_left
					cmp ebx,2
					je short two_left
					cmp ebx,3
					je short three_left

	one_left:		movss real4 ptr [edi],xmm6
					jmp short done
	two_left:		insertps xmm2,xmm6,01000000b
					movss real4 ptr [edi],xmm6
					movss real4 ptr [edi + 4],xmm2	
					jmp short done
	three_left:		insertps xmm2,xmm6,01000000b
					insertps xmm4,xmm6,10000000b
					movss real4 ptr [edi],xmm6
					movss real4 ptr [edi + 4],xmm2
					movss real4 ptr [edi + 8],xmm4

			done:	vzeroupper
					pop edi
					pop ebx
					mov esp,ebp
					pop ebp
					ret	8
sub_avx2_ps@@16		endp

;;								ecx,						edx
;;		bool sub_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
;;							double *out_aligned_32,int n);
sub_avx2_pd@@16		proc near
						out_ptr		textequ		<[ebp + 8]>
						n_arg		textequ		<[ebp + 12]>
					push ebp
					mov ebp,esp
					push ebx
					push edi

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					mov edi,out_ptr
					test edi,1fh
					jnz done

					mov ebx,n_arg
					cmp ebx,4
					jl too_short

					mov eax,ebx
					and ebx,0fffffffch
					sub eax,ebx
					shr ebx,2

			@@:		vmovapd ymm0,ymmword ptr [ecx]
					vsubpd ymm7,ymm0,ymmword ptr [edx]
					vmovapd ymmword ptr [edi],ymm7
					add ecx,32
					add edx,32
					add edi,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [ecx]
					vsubpd ymm7,ymm0,ymmword ptr [edx]

					cmp ebx,1
					je short one_left
					cmp ebx,2
					je short two_left
					cmp ebx,3
					je short three_left

	one_left:		vmovsd real8 ptr [edi],xmm7   
					jmp short done
	two_left:		vmovsd real8 ptr [edi],xmm7
					movhlps xmm2,xmm7
					vmovsd real8 ptr [edi + 8],xmm2 
					jmp short done
	three_left:		vextractf128 xmm6,ymm7,1	
					movhlps xmm2,xmm7
					vmovsd real8 ptr [edi],xmm7
					vmovsd real8 ptr [edi + 8],xmm2
					vmovsd real8 ptr [edi + 16],xmm6

		done:		vzeroupper	
					pop edi
					pop ebx
					mov esp,ebp
					pop ebp
					ret 8
sub_avx2_pd@@16		endp

;;									ecx,						xmm0
;;		bool sub_broad1_avx2_ps(float const *in1_aligned_32, float const in2,
;;									edx
;;							float *out_aligned_32,int n);
sub_broad1_avx2_ps@@16	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastss ymm6, xmm0 	

						mov ebx,n_arg
						cmp ebx,8
						jl too_short

						mov eax,ebx
						and ebx,0fffffff8h
						sub eax,ebx
						shr ebx,3

				@@:		vmovaps ymm0,ymmword ptr [ecx]
						vsubps ymm3,ymm0,ymm6
						vmovaps ymmword ptr [edx],ymm3
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovaps ymm0,ymmword ptr [ecx]
						vsubps ymm3,ymm0,ymm6

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

				done:	vzeroupper
						pop ebx
						mov esp,ebp
						pop ebp
						ret	4
sub_broad1_avx2_ps@@16	endp

;;									ecx,							xmm0
;;		 bool sub_broad1_avx2_pd(double const *in1_aligned_32, double const in2,
;;										edx
;;								double *out_aligned_32,int n);
sub_broad1_avx2_pd@@20	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastsd ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,4
						jl too_short

						mov eax,ebx
						and ebx,0fffffffch
						sub eax,ebx
						shr ebx,2

				@@:		vmovapd ymm0,ymmword ptr [ecx]
						vsubpd ymm7,ymm0,ymm6
						vmovapd ymmword ptr [edx],ymm7
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovapd ymm0,ymmword ptr [ecx]
						vsubpd ymm7,ymm0,ymm6

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
sub_broad1_avx2_pd@@20	endp

;;									xmm0,				ecx
;;		bool sub_broad2_avx2_ps(float const in1, float const *in2_aligned_32,
;;									edx
;;							float *out_aligned_32,int n);
sub_broad2_avx2_ps@@16	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastss ymm6, xmm0 	

						mov ebx,n_arg
						cmp ebx,8
						jl too_short

						mov eax,ebx
						and ebx,0fffffff8h
						sub eax,ebx
						shr ebx,3

				@@:		vmovaps ymm0,ymmword ptr [ecx]
						vsubps ymm3,ymm6,ymm0
						vmovaps ymmword ptr [edx],ymm3
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovaps ymm0,ymmword ptr [ecx]
						vsubps ymm3,ymm6,ymm0

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

				done:	vzeroupper	
						pop ebx
						mov esp,ebp
						pop ebp
						ret	4
sub_broad2_avx2_ps@@16	endp

;;										xmm0,				ecx
;;		 bool sub_broad2_avx2_pd(double const in1, double const *in2_aligned_32,
;;										edx
;;								double *out_aligned_32,int n);
sub_broad2_avx2_pd@@20	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastsd ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,4
						jl too_short

						mov eax,ebx
						and ebx,0fffffffch
						sub eax,ebx
						shr ebx,2

				@@:		vmovapd ymm0,ymmword ptr [ecx]
						vsubpd ymm7,ymm6,ymm0
						vmovapd ymmword ptr [edx],ymm7
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovapd ymm0,ymmword ptr [ecx]
						vsubpd ymm7,ymm6,ymm0

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
sub_broad2_avx2_pd@@20	endp

;;										ecx,					edx
;;		bool mul_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
;;							float *out_aligned_32,int n);
mul_avx2_ps@@16		proc near
						out_ptr		textequ		<[ebp + 8]>
						n_arg		textequ		<[ebp + 12]>
					push ebp
					mov ebp,esp
					push ebx
					push edi
					
					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					mov edi,out_ptr
					test edi,1fh
					jnz done

					mov ebx,n_arg
					cmp ebx,8
					jl too_short

					mov eax,ebx
					and ebx,0fffffff8h
					sub eax,ebx
					shr ebx,3

			@@:		vmovaps ymm0,ymmword ptr [ecx]
					vmulps ymm3,ymm0,ymmword ptr [edx]
					vmovaps ymmword ptr [edi],ymm3
					add ecx,32
					add edx,32
					add edi,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [ecx]
					vmulps ymm3,ymm0,ymmword ptr [edx]

					movaps xmm6,xmm3	
					cmp ebx,4
					jl short rem_left
					vextractf128 xmm6,ymm3,1 
					movaps xmmword ptr [edi],xmm3
					add edi,16
					sub ebx,4
					jz done

	rem_left:		cmp ebx,1
					je short one_left
					cmp ebx,2
					je short two_left
					cmp ebx,3
					je short three_left

	one_left:		movss real4 ptr [edi],xmm6
					jmp short done
	two_left:		insertps xmm2,xmm6,01000000b
					movss real4 ptr [edi],xmm6
					movss real4 ptr [edi + 4],xmm2	
					jmp short done
	three_left:		insertps xmm2,xmm6,01000000b
					insertps xmm4,xmm6,10000000b
					movss real4 ptr [edi],xmm6
					movss real4 ptr [edi + 4],xmm2
					movss real4 ptr [edi + 8],xmm4

		done:		vzeroupper
					pop edi
					pop ebx
					mov esp,ebp
					pop ebp
					ret 8
mul_avx2_ps@@16		endp

;;								ecx,						edx
;;		bool mul_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
;;							double *out_aligned_32,int n);
mul_avx2_pd@@16		proc near
						out_ptr			textequ		<[ebp + 8]>
						n_arg			textequ		<[ebp + 12]>
					push ebp
					mov ebp,esp
					push ebx
					push edi

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					mov edi,out_ptr
					test edi,1fh
					jnz done

					mov ebx,n_arg
					cmp ebx,4
					jl too_short

					mov eax,ebx
					and ebx,0fffffffch
					sub eax,ebx
					shr ebx,2

			@@:		vmovapd ymm0,ymmword ptr [ecx]
					vmulpd ymm7,ymm0,ymmword ptr [edx]
					vmovapd ymmword ptr [edi],ymm7
					add ecx,32
					add edx,32
					add edi,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [ecx]
					vmulpd ymm7,ymm0,ymmword ptr [edx]

					cmp ebx,1
					je short one_left
					cmp ebx,2
					je short two_left
					cmp ebx,3
					je short three_left

	one_left:		vmovsd real8 ptr [edi],xmm7   
					jmp short done
	two_left:		vmovsd real8 ptr [edi],xmm7
					movhlps xmm2,xmm7
					vmovsd real8 ptr [edi + 8],xmm2 
					jmp short done
	three_left:		vextractf128 xmm6,ymm7,1	
					movhlps xmm2,xmm7
					vmovsd real8 ptr [edi],xmm7
					vmovsd real8 ptr [edi + 8],xmm2
					vmovsd real8 ptr [edi + 16],xmm6

		done:		vzeroupper
					pop edi
					pop ebx
					mov esp,ebp
					pop ebp
					ret 8
mul_avx2_pd@@16		endp

;;									ecx,					xmm0
;;		bool mul_broad_avx2_ps(float const *in1_aligned_32, float const in2,
;;									edx
;;							float *out_aligned_32,int n);
mul_broad_avx2_ps@@16	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx
	
						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastss ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,8
						jl too_short

						mov eax,ebx
						and ebx,0fffffff8h
						sub eax,ebx
						shr ebx,3

				@@:		vmovaps ymm0,ymmword ptr [ecx]
						vmulps ymm3,ymm0,ymm6
						vmovaps ymmword ptr [edx],ymm3
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovaps ymm0,ymmword ptr [ecx]
						vmulps ymm3,ymm0,ymm6

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

			done:		vzeroupper
						pop ebx
						mov esp,ebp
						pop ebp
						ret 4
mul_broad_avx2_ps@@16	endp

;;									ecx,						xmm0
;;		bool mul_broad_avx2_pd(double const *in1_aligned_32, double const in2,
;;										edx
;;							double *out_aligned_32,int n);
mul_broad_avx2_pd@@20	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastsd ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,4
						jl too_short

						mov eax,ebx
						and ebx,0fffffffch
						sub eax,ebx
						shr ebx,2

				@@:		vmovapd ymm0,ymmword ptr [ecx]
						vmulpd ymm7,ymm0,ymm6
						vmovapd ymmword ptr [edx],ymm7
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovapd ymm0,ymmword ptr [ecx]
						vmulpd ymm7,ymm0,ymm6

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
mul_broad_avx2_pd@@20	endp

;;								ecx,					edx
;;		bool div_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
;;							float *out_aligned_32,int n);
div_avx2_ps@@16		proc near
						out_ptr		textequ		<[ebp + 8]>
						n_arg		textequ		<[ebp + 12]>
					push ebp
					mov ebp,esp
					push ebx
					push edi

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					mov edi,out_ptr
					test edi,1fh
					jnz done

					mov ebx,n_arg
					cmp ebx,8
					jl too_short

					mov eax,ebx
					and ebx,0fffffff8h
					sub eax,ebx
					shr ebx,3

			@@:		vmovaps ymm0,ymmword ptr [ecx]
					vdivps ymm3,ymm0,ymmword ptr [edx]
					vmovaps ymmword ptr [edi],ymm3
					add ecx,32
					add edx,32
					add edi,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [ecx]
					vdivps ymm3,ymm0,ymmword ptr [edx]

					movaps xmm6,xmm3	
					cmp ebx,4
					jl short rem_left
					vextractf128 xmm6,ymm3,1 
					movaps xmmword ptr [edi],xmm3
					add edi,16
					sub ebx,4
					jz done

	rem_left:		cmp ebx,1
					je short one_left
					cmp ebx,2
					je short two_left
					cmp ebx,3
					je short three_left

	one_left:		movss real4 ptr [edi],xmm6
					jmp short done
	two_left:		insertps xmm2,xmm6,01000000b
					movss real4 ptr [edi],xmm6
					movss real4 ptr [edi + 4],xmm2	
					jmp short done
	three_left:		insertps xmm2,xmm6,01000000b
					insertps xmm4,xmm6,10000000b
					movss real4 ptr [edi],xmm6
					movss real4 ptr [edi + 4],xmm2
					movss real4 ptr [edi + 8],xmm4

		done:		vzeroupper
					pop edi
					pop ebx
					mov esp,ebp
					pop ebp
					ret 8
div_avx2_ps@@16		endp

;;								ecx,					edx
;;		bool div_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
;;							double *out_aligned_32, int n);
div_avx2_pd@@16		proc  near
						out_ptr			textequ		<[ebp + 8]>
						n_arg			textequ		<[ebp + 12]>
					push ebp
					mov ebp,esp
					push ebx
					push edi

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					mov edi,out_ptr
					test edi,1fh
					jnz done

					mov ebx,n_arg
					cmp ebx,4
					jl too_short

					mov eax,ebx
					and ebx,0fffffffch
					sub eax,ebx
					shr ebx,2

			@@:		vmovapd ymm0,ymmword ptr [ecx]
					vdivpd ymm7,ymm0,ymmword ptr [edx]
					vmovapd ymmword ptr [edi],ymm7
					add ecx,32
					add edx,32
					add edi,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [ecx]
					vdivpd ymm7,ymm0,ymmword ptr [edx]

					cmp ebx,1
					je short one_left
					cmp ebx,2
					je short two_left
					cmp ebx,3
					je short three_left

	one_left:		vmovsd real8 ptr [edi],xmm7   
					jmp short done
	two_left:		vmovsd real8 ptr [edi],xmm7
					movhlps xmm2,xmm7
					vmovsd real8 ptr [edi + 8],xmm2 
					jmp short done
	three_left:		vextractf128 xmm6,ymm7,1	
					movhlps xmm2,xmm7
					vmovsd real8 ptr [edi],xmm7
					vmovsd real8 ptr [edi + 8],xmm2
					vmovsd real8 ptr [edi + 16],xmm6

		done:		vzeroupper
					pop edi
					pop ebx
					mov esp,ebp
					pop ebp
					ret 8
div_avx2_pd@@16		endp

;;										ecx,					xmm0				
;;		bool div_broad1_avx2_ps(float const *in1_aligned_32, float const in2,
;;									edx
;;							float *out_aligned_32, int n);
div_broad1_avx2_ps@@16	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastss ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,8
						jl too_short

						mov eax,ebx
						and ebx,0fffffff8h
						sub eax,ebx
						shr ebx,3

				@@:		vmovaps ymm0,ymmword ptr [ecx]
						vdivps ymm3,ymm0,ymm6
						vmovaps ymmword ptr [edx],ymm3
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovaps ymm0,ymmword ptr [ecx]
						vdivps ymm3,ymm0,ymm6

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

			done:		vzeroupper
						pop ebx
						mov esp,ebp
						pop ebp
						ret 4
div_broad1_avx2_ps@@16	endp

;;										ecx,					xmm0
;;		bool div_broad1_avx2_pd(double const *in1_aligned_32, double const in2,
;;									edx
;;							double *out_aligned_32,int n);
div_broad1_avx2_pd@@20	proc  near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastsd ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,4
						jl too_short

						mov eax,ebx
						and ebx,0fffffffch
						sub eax,ebx
						shr ebx,2

				@@:		vmovapd ymm0,ymmword ptr [ecx]
						vdivpd ymm7,ymm0,ymm6
						vmovapd ymmword ptr [edx],ymm7
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovapd ymm0,ymmword ptr [ecx]
						vdivpd ymm7,ymm0,ymm6

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
div_broad1_avx2_pd@@20	endp

;;									xmm0,					ecx
;;		bool div_broad2_avx2_ps(float const in1, float const in2_aligned_32,
;;									edx
;;							float *out_aligned_32,int n);
div_broad2_avx2_ps@@16	proc near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastss ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,8
						jl too_short

						mov eax,ebx
						and ebx,0fffffff8h
						sub eax,ebx
						shr ebx,3

				@@:		vmovaps ymm0,ymmword ptr [ecx]
						vdivps ymm3,ymm6,ymm0
						vmovaps ymmword ptr [edx],ymm3
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovaps ymm0,ymmword ptr [ecx]
						vdivps ymm3,ymm6,ymm0

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

			done:		vzeroupper
						pop ebx
						mov esp,ebp
						pop ebp
						ret 4
div_broad2_avx2_ps@@16	endp

;;									xmm0,					ecx
;;		bool div_broad2_avx2_pd(double const in1, double const *in2_aligned_32,
;;									edx
;;							double *out_aligned_32,int n);
div_broad2_avx2_pd@@20	proc  near
							n_arg		textequ		<[ebp + 8]>
						push ebp
						mov ebp,esp
						push ebx

						test ecx,1fh
						jnz done

						test edx,1fh
						jnz done

						vbroadcastsd ymm6,xmm0

						mov ebx,n_arg
						cmp ebx,4
						jl too_short

						mov eax,ebx
						and ebx,0fffffffch
						sub eax,ebx
						shr ebx,2

				@@:		vmovapd ymm0,ymmword ptr [ecx]
						vdivpd ymm7,ymm6,ymm0
						vmovapd ymmword ptr [edx],ymm7
						add ecx,32
						add edx,32
						dec ebx
						jnz @B

						mov ebx,eax
		too_short:		or ebx,ebx								
						mov eax,1
						jz done

						vmovapd ymm0,ymmword ptr [ecx]
						vdivpd ymm7,ymm6,ymm0

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
div_broad2_avx2_pd@@20	endp

;;									ecx,					edx
;;		bool inv_avx2_ps(float const *in_aligned_32,float *out_aligned_32,int n);
inv_avx2_ps@@12		proc near
						n_arg		textequ		<[ebp + 8]>
					push ebp
					mov ebp,esp
					push ebx

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					vmovups ymm6,ymmword ptr [one_ps]

					mov ebx,n_arg
					cmp ebx,8
					jl too_short

					mov eax,ebx
					and ebx,0fffffff8h
					sub eax,ebx
					shr ebx,3

			@@:		vmovaps ymm0,ymmword ptr [ecx]
					vdivps ymm3,ymm6,ymm0
					vmovaps ymmword ptr [edx],ymm3
					add ecx,32
					add edx,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [ecx]
					vdivps ymm3,ymm6,ymm0

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

			done:	vzeroupper	
					pop ebx
					mov esp,ebp
					pop ebp
					ret	4
inv_avx2_ps@@12		endp

;;								ecx,					edx
;;		 bool inv_avx2_pd(double const *in_aligned_32, double *out_aligned_32,int n,);
inv_avx2_pd@@12		proc near
						n_arg		textequ		<[ebp + 8]>
					push ebp
					mov ebp,esp
					push ebx

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					vmovupd ymm6,ymmword ptr [one_pd]

					mov ebx,n_arg
					cmp ebx,4
					jl too_short

					mov eax,ebx
					and ebx,0fffffffch
					sub eax,ebx
					shr ebx,2

			@@:		vmovapd ymm0,ymmword ptr [ecx]
					vdivpd ymm7,ymm6,ymm0
					vmovapd ymmword ptr [edx],ymm7
					add ecx,32
					add edx,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [ecx]
					vdivpd ymm7,ymm6,ymm0

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
inv_avx2_pd@@12		endp

;;								ecx,					edx
;;		bool neg_avx2_ps(float const *in_aligned_32,float *out_aligned_32,int n);
neg_avx2_ps@@12		proc near
						n_arg		textequ		<[ebp + 8]>
					push ebp
					mov ebp,esp
					push ebx

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					vmovups ymm6,ymmword ptr [neg_sign_mask_d]

					mov ebx,n_arg
					cmp ebx,8
					jl too_short

					mov eax,ebx
					and ebx,0fffffff8h
					sub eax,ebx
					shr ebx,3

			@@:		vmovaps ymm0,ymmword ptr [ecx]
					vxorps ymm3,ymm0,ymm6;;ymmword ptr [neg_sign_mask_d]
					vmovaps ymmword ptr [edx],ymm3
					add ecx,32
					add edx,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [ecx]
					vxorps ymm3,ymm0,ymm6;;ymmword ptr [neg_sign_mask_d]

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

			done:	vzeroupper	
					pop ebx
					mov esp,ebp
					pop ebp
					ret	4
neg_avx2_ps@@12		endp

;;								ecx,					edx	
;;		 bool neg_avx2_pd(double const *in_aligned_32,double *out_aligned_32,int n);
neg_avx2_pd@@12		proc near
						n_arg		textequ		<[ebp + 8]>
					push ebp
					mov ebp,esp
					push ebx

					test ecx,1fh
					jnz done

					test edx,1fh
					jnz done

					vmovupd ymm6,ymmword ptr [neg_sign_mask_q]

					mov ebx,n_arg
					cmp ebx,4
					jl too_short

					mov eax,ebx
					and ebx,0fffffffch
					sub eax,ebx
					shr ebx,2

			@@:		vmovapd ymm0,ymmword ptr [ecx]
					vxorpd ymm7,ymm0,ymm6;;ymmword ptr [neg_sign_mask_q]
					vmovapd ymmword ptr [edx],ymm7
					add ecx,32
					add edx,32
					dec ebx
					jnz @B

					mov ebx,eax
	too_short:		or ebx,ebx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [ecx]
					vxorpd ymm7,ymm0,ymm6;;ymmword ptr [neg_sign_mask_q]

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
neg_avx2_pd@@12		endp
					end

