.model flat,c

;; ============================= CONSTANTS =================================
.const 
align 16	
;; ============= packed single precision floating point for BO ============
one_ps						real4   1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0

;; =========== packed double precision floating point for BO ================

one_pd						real8	1.0,1.0,1.0,1.0
;; ============================ GENERAL =======================================
pos_sign_mask_d				dword	7fffffffh,7fffffffh,7fffffffh,7fffffffh
							dword	7fffffffh,7fffffffh,7fffffffh,7fffffffh
neg_sign_mask_d				dword	80000000h,80000000h,80000000h,80000000h
							dword	80000000h,80000000h,80000000h,80000000h
pos_sign_mask_q				qword	7fffffffffffffffh,7fffffffffffffffh   
							qword	7fffffffffffffffh,7fffffffffffffffh
neg_sign_mask_q				qword	8000000000000000h,8000000000000000h
							qword	8000000000000000h,8000000000000000h
;; ============================ PROTOTYPES ==================================

abs_avx2_ps			proto,
						in_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4

abs_avx2_pd			proto,
						in_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8

sqrt_avx2_ps		proto,
						in_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4	

sqrt_avx2_pd		proto,
						in_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8

sqrp_avx2_ps		proto,
						in_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4

sqrp_avx2_pd		proto,
						in_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8

min_avx2_ps			proto,
						in1_ptr:ptr real4,
						in2_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4

min_avx2_pd			proto,
						in1_ptr:ptr real8,
						in2_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8

min_broad_avx2_ps	proto,
						in_ptr: ptr real4,
						in_arg:real4,
						n_arg:dword,
						out_ptr: ptr real4

min_broad_avx2_pd	proto,
						in_ptr:ptr real8,
						in_arg:real8,
						n_arg:dword,
						out_ptr:ptr real8

max_avx2_ps			proto,
						in1_ptr:ptr real4,
						in2_ptr:ptr real4,
						n_arg:dword,
						out_ptr:ptr real4

max_avx2_pd			proto,
						in1_ptr:ptr real8,
						in2_ptr:ptr real8,
						n_arg:dword,
						out_ptr:ptr real8

max_broad_avx2_ps	proto,
						in_ptr: ptr real4,
						in_arg:real4,
						n_arg:dword,
						out_ptr: ptr real4

max_broad_avx2_pd	proto,
						in_ptr:ptr real8,
						in_arg:real8,
						n_arg:dword,
						out_ptr:ptr real8