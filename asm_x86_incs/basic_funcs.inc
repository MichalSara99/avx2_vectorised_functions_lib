.model flat

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
