#
#
# Contains reading and writing function utility functions
#
#

module parcing

using ITensors
using DelimitedFiles
include("component_def.jl")


export Read_InPutFile, Write_OutPutFile, Index_setup, check_str, Tensor_Setup
export gate_set, set_qinit, measure_set, density_out, write_wave_out, isin, flattenA

##########
#
# Utility functions
#
##########

# Check if a is a string.
function check_str(a)
    try
        parse(Int64,a)
        true
    catch
        false
    end
end

# Checks if n is in A.
function isin(A,n)
 t = false
 for i=1:length(A)
   if isa(A[i],Array)
    for j=1:length(A[i])
     if isin(A[i][j],n)
      t=true
     end
    end
   else
     if A[i] == n
      t=true
     end
   end
 end
 return t

end

# Removes one layer of an array. [[i,j],k]--> [i,j,k]
function flattenA(A)
 b=[]
 for i=1:length(A)
   if length(A[i])>1
      for j=1:length(A[i])
       push!(b,A[i][j])
      end
    else
     push!(b,A[i])
    end
   end

 return b
end


##########
#
# Read in and set up functions
#
##########

# Sets up the indexs for the Tensors
function Index_setup(a)

    d=Index[]
    for i=1:a
        append!(d,[Index(4),Index(4)])
    end
    d=reshape(d,(a,2))
    return d

end

# Reads the input file
function Read_InPutFile(InPutFile)

 a=[]
 open(InPutFile) do f
   i=1
   while !eof(f)
    x=readline(f)
    append!(a,[split(x, " ")])
   end
 end
 
 
 return a

end

# Sets the initial states
function Inital_State(N,d,a)
 Q=ITensor[]
 for i=1:N
  push!(Q,component_def.Init_st(d[i,2],a[1+i]))
 end
 return Q
end

# Gets a tensor for a Gate
function gate_set(s,n,d)


   if s == "H"

       Ham=component_def.HGate(d[n,1],d[n,2]) 
     
   end
   
   if s == "X"

       Ham=component_def.XGate(d[n,1],d[n,2]) 
     
   end
   
   if s == "CN" || s == "CX"

       Ham=component_def.CNotGate(d[n[1],1],d[n[1],2],d[n[2],1],d[n[2],2]) 
     
   end

 
   if s == "Y"

       Ham=component_def.YGate(d[n,1],d[n,2]) 
     
   end
   
   if s == "Z"

       Ham=component_def.ZGate(d[n,1],d[n,2]) 
     
   end
   
   if s == "I"

       Ham=component_def.ZGate(d[n,1],d[n,2]) 
     
   end
   
   if s == "Rx"

       Ham=component_def.RxGate(d[Int64(n[1]),1],d[Int64(n[1]),2],n[2]) 
     
   end
   
   if s == "Ry"

       Ham=component_def.RyGate(d[Int64(n[1]),1],d[Int64(n[1]),2],n[2]) 
     
   end
   
   if s == "Rz"

       Ham=component_def.RzGate(d[Int64(n[1]),1],d[Int64(n[1]),2],n[2]) 
     
   end

   if s == "SW"

       Ham=component_def.SWGate(d[n[1],1],d[n[1],2],d[n[2],1],d[n[2],2]) 
     
   end 
   
   if s == "CZ"

       Ham=component_def.CZGate(d[n[1],1],d[n[1],2],d[n[2],1],d[n[2],2]) 
     
   end

   if s == "CP"

       Ham=component_def.CPhaseGate(d[Int64(n[1]),1],d[Int64(n[1]),2],d[Int64(n[2]),1],d[Int64(n[2]),2],n[3]) 
     
   end
   
   if s == "CR"

       Ham=component_def.CRGate(d[n[1],1],d[n[1],2],d[n[2],1],d[n[2],2],n[3]) 
     
   end
   
 return Ham
end

function measure_set(s,n,d)

   
   if s == "X"

       Ham=component_def.XMeasure(d[n,1]) 
     
   end
   
   if s == "Y"
     
       Ham=component_def.YMeasure(d[n,1]) 
     
   end
   
   if s == "Z"
     
       Ham=component_def.ZMeasure(d[n,1]) 
     
   end

 return Ham
end

function set_qinit(S,d,N)
 Q=ITensor[]
 for i=1:N
  push!(Q,component_def.Init_st(d[i,2],S[i]))
 end
 return Q
end


##########
#
# Output functions
#
##########

# Writes an output file
function Write_OutPutFile(a,OutFile)

 io=open(OutFile, "w")
#   for i=1:length(a)
#     println(a[i])
    writedlm(io,a," ")
#  end
 close(io)

end

# Prints a wavefunction to the screen
function write_wave_out(T)
 if sign(T[2]) == 0
  println(sqrt(T[1]),' ', sqrt(T[4]))
 else
  println(sqrt(T[1]),' ', sign(T[2])*sqrt(T[4]))
 end
end


function Fun_N(i,j,L,L2,W)
    if length(L)>1
        if i > L[1]
            if j > L2[1]
                return 3*W[1]+Fun_N(i-L[1],j-L2[1],L[2:end],L2[2:end],W[2:end])
            else
                return 1*W[1]+Fun_N(i-L[1],j,L[2:end],L2[2:end],W[2:end])
            end
        else
            if j > L2[1]
                return 2*W[1]+Fun_N(i,j-L2[1],L[2:end],L2[2:end],W[2:end]) 
            else
                return Fun_N(i,j,L[2:end],L2[2:end],W[2:end])
            end
        end
    else
        if i == 2 
           if j == 2
             return  1+ W[1]*3
           else
             return  1+ W[1]
           end
        else
           if j == 2
             return  1+ W[1]*2
           else
             return 1
           end 
        end
    end
end

function Fun_A(i,j,N,O)
    Lim=[]
    W=[4,1]
    for k=1:O
       push!(Lim,N/(2^k)) 
    end
    if O>2
        for k=3:O
            push!(W,4^(k-1))
        end
    end
    #println(Lim)
    #println(W)
    #println(Fun_N(i,j,Lim,Lim,W))
    return Int64(Fun_N(i,j,Lim,Lim,W))
end


# Prints a density matrix to the screen
function write_density_out(T)

    N=length(T.store)
    M=N/4
    A=isqrt(N)
    B=order(T)
    n=0
    if B ==1
        P=transpose(reshape(T.store,A,A))
    else    
        P=zeros(Float64,A,A)
        for i=1:A
            for j=1:A
                n=Fun_A(j,i,A,B)
                P[i,j]=T.store[n]  
            end
        end
    end

    for i=1:A
        println(P[i,:])
    end

end



end
