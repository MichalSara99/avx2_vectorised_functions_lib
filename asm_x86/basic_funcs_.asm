include asm_x86_incs/basic_funcs.inc

.code
;; bool abs_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);
abs_avx2_ps			proc uses esi,
						in_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4

					mov esi,in_ptr
					test esi,1fh
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

			@@:		vmovaps ymm0,ymmword ptr [esi]
					vandps ymm3,ymm0,ymmword ptr [pos_sign_mask_d]
					vmovaps ymmword ptr [edx],ymm3
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [esi]
					vandps ymm3,ymm0,ymmword ptr [pos_sign_mask_d]

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

			done:	vzeroupper	
					ret	
abs_avx2_ps			endp

;; bool abs_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);
abs_avx2_pd			proc uses esi,
						in_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8

					mov esi,in_ptr
					test esi,1fh
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

			@@:		vmovapd ymm0,ymmword ptr [esi]
					vandpd ymm7,ymm0,ymmword ptr [pos_sign_mask_q]
					vmovapd ymmword ptr [edx],ymm7
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [esi]
					vandpd ymm7,ymm0,ymmword ptr [pos_sign_mask_q]

					cmp ecx,1
					je short one_left
					cmp ecx,2
					je short two_left
					cmp ecx,3
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
					ret
abs_avx2_pd			endp

;;	bool sqrt_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);
sqrt_avx2_ps		proc uses esi,
						in_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4	
						
					mov esi,in_ptr
					test esi,1fh
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

			@@:		vsqrtps ymm3,ymmword ptr [esi]
					vmovaps ymmword ptr [edx],ymm3
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vsqrtps ymm3,ymmword ptr [esi]

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

			done:	vzeroupper	
					ret	
sqrt_avx2_ps		endp

;;	bool sqrt_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);
sqrt_avx2_pd		proc uses esi,
						in_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8					

					mov esi,in_ptr
					test esi,1fh
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

			@@:		vsqrtpd ymm0,ymmword ptr [esi]
					vmovapd ymmword ptr [edx],ymm0
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vsqrtpd ymm7,ymmword ptr [esi]

					cmp ecx,1
					je short one_left
					cmp ecx,2
					je short two_left
					cmp ecx,3
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
					ret
sqrt_avx2_pd		endp

;;	bool sqrp_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);
sqrp_avx2_ps		proc uses esi,
						in_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4	
						
					mov esi,in_ptr
					test esi,1fh
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

			@@:		vmovaps ymm0,ymmword ptr [esi]
					vmulps ymm3,ymm0,ymm0
					vmovaps ymmword ptr [edx],ymm3
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [esi]
					vmulps ymm3,ymm0,ymm0

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

			done:	vzeroupper	
					ret	
sqrp_avx2_ps		endp

;;	bool sqrp_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);
sqrp_avx2_pd		proc uses esi,
						in_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8					

					mov esi,in_ptr
					test esi,1fh
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

			@@:		vmovapd ymm0,ymmword ptr [esi]
					vmulpd ymm7,ymm0,ymm0
					vmovapd ymmword ptr [edx],ymm7
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [esi]
					vmulpd ymm7,ymm0,ymm0

					cmp ecx,1
					je short one_left
					cmp ecx,2
					je short two_left
					cmp ecx,3
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
					ret
sqrp_avx2_pd		endp

;;	bool min_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32, int n, float *out_aligned_32);
min_avx2_ps			proc uses esi ebx,
						in1_ptr:ptr real4,
						in2_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4	
						
					mov esi,in1_ptr
					test esi,1fh
					jnz done

					mov ebx,in2_ptr
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

			@@:		vmovaps ymm0,ymmword ptr [esi]
					vminps ymm3,ymm0,ymmword ptr [ebx]
					vmovaps ymmword ptr [edx],ymm3
					add esi,32
					add ebx,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [esi]
					vminps ymm3,ymm0,ymmword ptr [ebx]

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

			done:	vzeroupper	
					ret	
min_avx2_ps			endp

;;	bool min_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32, int n, double *out_aligned_32);
min_avx2_pd			proc uses esi ebx,
						in1_ptr:ptr real8,
						in2_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8

					mov esi,in1_ptr
					test esi,1fh
					jnz done

					mov ebx,in2_ptr
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

			@@:		vmovapd ymm0,ymmword ptr [esi]
					vminpd ymm7,ymm0,ymmword ptr [ebx]
					vmovapd ymmword ptr [edx],ymm7
					add esi,32
					add edx,32
					add ebx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [esi]
					vminpd ymm7,ymm0,ymmword ptr [ebx]

					cmp ecx,1
					je short one_left
					cmp ecx,2
					je short two_left
					cmp ecx,3
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
					ret
min_avx2_pd			endp

;;	bool min_broad_avx2_ps(float const *in1_aligned_32, float const in2, int n, float *out_aligned_32);
min_broad_avx2_ps	proc uses esi,
						in_ptr: ptr real4,
						in_arg:real4,
						n_arg:dword,
						out_ptr: ptr real4

					mov esi,in_ptr
					test esi,1fh
					jnz done

					mov edx,out_ptr
					test edx,1fh
					jnz done

					vbroadcastss ymm6,in_arg

					mov ecx,n_arg
					cmp ecx,8
					jl too_short

					mov eax,ecx
					and ecx,0fffffff8h
					sub eax,ecx
					shr ecx,3

			@@:		vmovaps ymm0,ymmword ptr [esi]
					vminps ymm3,ymm0,ymm6
					vmovaps ymmword ptr [edx],ymm3
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [esi]
					vminps ymm3,ymm0,ymm6

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

			done:	vzeroupper	
					ret	
min_broad_avx2_ps	endp

;;	bool min_broad_avx2_pd(double const *in1_aligned_32, double const in2, int n, double *out_aligned_32);
min_broad_avx2_pd	proc uses esi,
						in_ptr:ptr real8,
						in_arg:real8,
						n_arg:dword,
						out_ptr:ptr real8

					mov esi,in_ptr
					test esi,1fh
					jnz done

					mov edx,out_ptr
					test edx,1fh
					jnz done

					vbroadcastsd ymm6,in_arg

					mov ecx,n_arg
					cmp ecx,4
					jl too_short

					mov eax,ecx
					and ecx,0fffffffch
					sub eax,ecx
					shr ecx,2

			@@:		vmovapd ymm0,ymmword ptr [esi]
					vminpd ymm7,ymm0,ymm6
					vmovapd ymmword ptr [edx],ymm7
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [esi]
					vminpd ymm7,ymm0,ymm6

					cmp ecx,1
					je short one_left
					cmp ecx,2
					je short two_left
					cmp ecx,3
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
					ret
min_broad_avx2_pd	endp

;;	bool max_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32, int n, float *out_aligned_32);
max_avx2_ps			proc uses esi ebx,
						in1_ptr:ptr real4,
						in2_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4	
						
					mov esi,in1_ptr
					test esi,1fh
					jnz done

					mov ebx,in2_ptr
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

			@@:		vmovaps ymm0,ymmword ptr [esi]
					vmaxps ymm3,ymm0,ymmword ptr [ebx]
					vmovaps ymmword ptr [edx],ymm3
					add esi,32
					add ebx,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [esi]
					vmaxps ymm3,ymm0,ymmword ptr [ebx]

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

			done:	vzeroupper	
					ret	
max_avx2_ps			endp

;;	bool max_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32, int n, double *out_aligned_32);
max_avx2_pd			proc uses esi ebx,
						in1_ptr:ptr real8,
						in2_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8

					mov esi,in1_ptr
					test esi,1fh
					jnz done

					mov ebx,in2_ptr
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

			@@:		vmovapd ymm0,ymmword ptr [esi]
					vmaxpd ymm7,ymm0,ymmword ptr [ebx]
					vmovapd ymmword ptr [edx],ymm7
					add esi,32
					add edx,32
					add ebx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [esi]
					vmaxpd ymm7,ymm0,ymmword ptr [ebx]

					cmp ecx,1
					je short one_left
					cmp ecx,2
					je short two_left
					cmp ecx,3
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
					ret
max_avx2_pd			endp

;;	bool max_broad_avx2_ps(float const *in1_aligned_32, float const in2, int n, float *out_aligned_32);
max_broad_avx2_ps	proc uses esi,
						in_ptr: ptr real4,
						in_arg:real4,
						n_arg:dword,
						out_ptr: ptr real4

					mov esi,in_ptr
					test esi,1fh
					jnz done

					mov edx,out_ptr
					test edx,1fh
					jnz done

					vbroadcastss ymm6,in_arg

					mov ecx,n_arg
					cmp ecx,8
					jl too_short

					mov eax,ecx
					and ecx,0fffffff8h
					sub eax,ecx
					shr ecx,3

			@@:		vmovaps ymm0,ymmword ptr [esi]
					vmaxps ymm3,ymm0,ymm6
					vmovaps ymmword ptr [edx],ymm3
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovaps ymm0,ymmword ptr [esi]
					vmaxps ymm3,ymm0,ymm6

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

			done:	vzeroupper	
					ret	
max_broad_avx2_ps	endp

;;	bool min_broad_avx2_pd(double const *in1_aligned_32, double const in2, int n, double *out_aligned_32);
max_broad_avx2_pd	proc uses esi,
						in_ptr:ptr real8,
						in_arg:real8,
						n_arg:dword,
						out_ptr:ptr real8

					mov esi,in_ptr
					test esi,1fh
					jnz done

					mov edx,out_ptr
					test edx,1fh
					jnz done

					vbroadcastsd ymm6,in_arg

					mov ecx,n_arg
					cmp ecx,4
					jl too_short

					mov eax,ecx
					and ecx,0fffffffch
					sub eax,ecx
					shr ecx,2

			@@:		vmovapd ymm0,ymmword ptr [esi]
					vmaxpd ymm7,ymm0,ymm6
					vmovapd ymmword ptr [edx],ymm7
					add esi,32
					add edx,32
					dec ecx
					jnz @B

					mov ecx,eax
	too_short:		or ecx,ecx								
					mov eax,1
					jz done

					vmovapd ymm0,ymmword ptr [esi]
					vmaxpd ymm7,ymm0,ymm6

					cmp ecx,1
					je short one_left
					cmp ecx,2
					je short two_left
					cmp ecx,3
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
					ret
max_broad_avx2_pd	endp
					end
