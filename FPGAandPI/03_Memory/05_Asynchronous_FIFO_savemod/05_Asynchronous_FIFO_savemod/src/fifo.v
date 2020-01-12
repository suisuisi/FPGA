//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-07 03:20:23
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-25 01:10:06
//# Description: 
//# @Modification History: 2018-05-29 10:14:07
//# Date          By         Version         Change Description: 
//# ========================================================================= #
//# 2018-05-29 10:14:07
//# ========================================================================= #
//# |                                                         | #
//# |                                OpenFPGA                   | #
//****************************************************************************//`timescale 1ns / 1ps
module fifo
#(
  parameter DSIZE = 8,        
  parameter ASIZE = 4
 ) 
 (
     output [DSIZE-1:0] rdata,  
     output             wfull,  
     output             rempty,  
     input  [DSIZE-1:0] wdata,  
     input              winc, wclk, wrst_n, 
     input              rinc, rclk, rrst_n
 );

  wire   [ASIZE-1:0] waddr, raddr;  
  wire   [ASIZE:0]   wptr, rptr, wq2_rptr, rq2_wptr;
// synchronize the read pointer into the write-clock domain
  sync_r2w  sync_r2w
  (
                    .wq2_rptr    (wq2_rptr),
                    .rptr        (rptr    ),                          
                    .wclk        (wclk    ), 
                    .wrst_n      (wrst_n  )  
 );

// synchronize the write pointer into the read-clock domain
  sync_w2r  sync_w2r 
  (
                   .rq2_wptr(rq2_wptr), 
                   .wptr(wptr),                          
                   .rclk(rclk),
                   .rrst_n(rrst_n)
 );

//this is the FIFO memory buffer that is accessed by both the write and read clock domains.
//This buffer is most likely an instantiated, synchronous dual-port RAM. 
//Other memory styles can be adapted to function as the FIFO buffer. 
  fifomem 
  #(DSIZE, ASIZE)
  fifomem                        
  (
      .rdata(rdata), 
      .wdata(wdata),                           
      .waddr(waddr),
      .raddr(raddr),                           
      .wclken(winc),
      .wfull(wfull),                           
      .wclk(wclk)
  );

//this module is completely synchronous to the read-clock domain and contains the FIFO read pointer and empty-flag logic.  
  rptr_empty
  #(ASIZE)    
  rptr_empty                          
  (
      .rempty(rempty),                          
      .raddr(raddr),                          
      .rptr(rptr),
      .rq2_wptr(rq2_wptr),                          
      .rinc(rinc),
      .rclk(rclk),                          
      .rrst_n(rrst_n)
  );

//this module is completely synchronous to the write-clock domain and contains the FIFO write pointer and full-flag logic
  wptr_full 
  #(ASIZE)    
  wptr_full                         
  (
      .wfull(wfull),
      .waddr(waddr),  
      .wptr(wptr),
      .wq2_rptr(wq2_rptr),    
      .winc(winc),
      .wclk(wclk),        
      .wrst_n(wrst_n)
  );
  endmodule