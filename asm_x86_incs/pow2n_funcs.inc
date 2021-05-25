.model flat,c

;; ============================= CONSTANTS =================================
.const
align 16
;; ============================== GENERAL ==================================
bias_q						qword	3ffh,3ffh,3ffh,3ffh
bias_d						dword	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh

;; ============================= PROTOTYPE =================================
pow2n_avx2_pd	proto,
			n_ptr:ptr qword,
			n_arg:dword,
			out_ptr:ptr real8


pow2n_avx2_ps	proto,
			n_ptr:ptr dword,
			n_arg:dword,
			out_ptr:ptr real4