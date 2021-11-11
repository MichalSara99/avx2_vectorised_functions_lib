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

add_avx2_ps proto,
			in1_ptr:ptr real4,
			in2_ptr:ptr real4,
			n_arg:dword,
			out_ptr:ptr real4

add_avx2_pd proto,
			in1_ptr:ptr real8,
			in2_ptr:ptr real8,
			n_arg:dword,
			out_ptr:ptr real8

add_broad_avx2_ps proto,
			in1_ptr:ptr real4,
			in2_arg:real4,
			n_arg:dword,
			out_ptr:ptr real4

add_broad_avx2_pd proto,
			in1_ptr:ptr real8,
			in2_arg:real8,
			n_arg:dword,
			out_ptr:ptr real8

sub_avx2_ps proto,
			in1_ptr:ptr real4,
			in2_ptr:ptr real4,
			n_arg:dword,
			out_ptr:ptr real4

sub_avx2_pd proto,
			in1_ptr:ptr real8,
			in2_ptr:ptr real8,
			n_arg:dword,
			out_ptr:ptr real8

sub_broad1_avx2_ps proto,
			in1_ptr:ptr real4,
			in2_arg:real4,
			n_arg:dword,
			out_ptr:ptr real4

sub_broad1_avx2_pd proto,
			in1_ptr:ptr real8,
			in2_arg:real8,
			n_arg:dword,
			out_ptr:ptr real8

sub_broad2_avx2_ps proto,
			in1_arg:real4,
			in2_ptr:ptr real4,
			n_arg:dword,
			out_ptr:ptr real4

sub_broad2_avx2_pd proto,
			in1_arg:real8,
			in2_ptr:ptr real8,
			n_arg:dword,
			out_ptr:ptr real8

mul_avx2_ps proto,
			in1_ptr:ptr real4,
			in2_ptr:ptr real4,
			n_arg:dword,
			out_ptr:ptr real4

mul_avx2_pd proto,
			in1_ptr:ptr real8,
			in2_ptr:ptr real8,
			n_arg:dword,
			out_ptr:ptr real8

mul_broad_avx2_ps proto,
			in1_ptr:ptr real4,
			in2_arg:real4,
			n_arg:dword,
			out_ptr:ptr real4

mul_broad_avx2_pd proto,
			in1_ptr:ptr real8,
			in2_arg:real8,
			n_arg:dword,
			out_ptr:ptr real8

div_avx2_ps proto,
			in1_ptr:ptr real4,
			in2_ptr:ptr real4,
			n_arg:dword,
			out_ptr:ptr real4

div_avx2_pd proto,
			in1_ptr:ptr real8,
			in2_ptr:ptr real8,
			n_arg:dword,
			out_ptr:ptr real8

div_broad1_avx2_ps proto,
			in1_ptr:ptr real4,
			in2_arg:real4,
			n_arg:dword,
			out_ptr:ptr real4

div_broad1_avx2_pd proto,
			in1_ptr:ptr real8,
			in2_arg:real8,
			n_arg:dword,
			out_ptr:ptr real8

div_broad2_avx2_ps proto,
			in1_arg:real4,
			in2_ptr:ptr real4,
			n_arg:dword,
			out_ptr:ptr real4

div_broad2_avx2_pd proto,
			in1_arg:real8,
			in2_ptr:ptr real8,
			n_arg:dword,
			out_ptr:ptr real8

inv_avx2_ps proto,
			in_ptr:ptr real4,
			n_arg:dword,
			out_ptr:ptr real4

inv_avx2_pd proto,
			in_ptr:ptr real8,
			n_arg:dword,
			out_ptr:ptr real8

neg_avx2_ps proto,
			in_ptr:ptr real4,
			n_arg:dword,
			out_ptr:ptr real4

neg_avx2_pd proto,
			in_ptr:ptr real8,
			n_arg:dword,
			out_ptr:ptr real8
