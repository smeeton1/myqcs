#include("../../ITensors.jl/src/ITensors.jl")
module component_def

# include("~/code/ITensors.jl/src/ITensors.jl")

using ITensors

export HGate, XGate, CNotGate, XMeasure, ZMeasure


function HGate(i::Index, j::Index)
  A = ITensor(i,j)

  A[i(1),j(1)]=1.0/2.0
  A[i(1),j(2)]=1.0/2.0
  A[i(1),j(3)]=1.0/2.0
  A[i(1),j(4)]=1.0/2.0
  A[i(2),j(1)]=1.0/2.0
  A[i(2),j(2)]=-1.0/2.0
  A[i(2),j(3)]=1.0/2.0
  A[i(2),j(4)]=-1.0/2.0
  A[i(3),j(1)]=1.0/2.0
  A[i(3),j(2)]=1.0/2.0
  A[i(3),j(3)]=-1.0/2.0
  A[i(3),j(4)]=-1.0/2.0
  A[i(4),j(1)]=1.0/2.0
  A[i(4),j(2)]=-1.0/2.0
  A[i(4),j(3)]=-1.0/2.0
  A[i(4),j(4)]=1.0/2.0
  
  return A

end 

function XGate(i::Index, j::Index)
  A = ITensor(i,j)

  A[i(1),j(4)]=1
  A[i(2),j(3)]=1
  A[i(3),j(2)]=1
  A[i(4),j(1)]=1

  return A

end 

function YGate(i::Index, j::Index)
  A = ITensor(i,j)

  A[i(1),j(4)]=1
  A[i(2),j(3)]=-1
  A[i(3),j(2)]=-1
  A[i(4),j(1)]=1

  return A

end 

function ZGate(i::Index, j::Index)
  A = ITensor(i,j)

  A[i(1),j(1)]=1
  A[i(2),j(2)]=-1
  A[i(3),j(3)]=-1
  A[i(4),j(4)]=1

  return A

end 

function CNotGate(i::Index, j::Index, k::Index, l::Index)
  A = ITensor(i,j,k,l)

  A[i(1),j(1),k(1),l(1)]=1
  A[i(1),j(2),k(1),l(2)]=1
  A[i(1),j(3),k(1),l(3)]=1
  A[i(1),j(4),k(1),l(4)]=1
  A[i(2),j(1),k(2),l(2)]=1
  A[i(2),j(2),k(2),l(1)]=1
  A[i(2),j(3),k(2),l(4)]=1
  A[i(2),j(4),k(2),l(3)]=1
  A[i(3),j(1),k(3),l(3)]=1
  A[i(3),j(2),k(3),l(4)]=1
  A[i(3),j(3),k(3),l(1)]=1
  A[i(3),j(4),k(3),l(2)]=1
  A[i(4),j(1),k(4),l(4)]=1
  A[i(4),j(2),k(4),l(3)]=1
  A[i(4),j(3),k(4),l(2)]=1
  A[i(4),j(4),k(4),l(1)]=1

  return A

end 

function RxGate(i::Index, j::Index, Phase)
  A = ITensor(i,j)

  A[i(1), j(1)] = pow(cos(Phase / 2.0), 2)
  A[i(1), j(2)] = (sin(Phase) / 2.0)im
  A[i(1), j(3)] = -1.0 * (sin(Phase) / 2.0)im
  A[i(1), j(4)] = pow(sin(Phase / 2.0), 2)
  A[i(2), j(1)] = (sin(Phase) / 2.0)im
  A[i(2), j(2)] = pow(cos(Phase / 2.0), 2)
  A[i(2), j(3)] = pow(sin(Phase / 2.0), 2)
  A[i(2), j(4)] = -1.0 * (sin(Phase) / 2.0)im
  A[i(3), j(1)] = -1.0 * (sin(Phase) / 2.0)im
  A[i(3), j(2)] = pow(sin(Phase / 2.0), 2)
  A[i(3), j(3)] = pow(cos(Phase / 2.0), 2)
  A[i(3), j(4)] = (sin(tPhase) / 2.0)im
  A[i(4), j(1)] = pow(sin(Phase / 2.0), 2)
  A[i(4), j(2)] = -1.0 * (sin(Phase) / 2.0)im
  A[i(4), j(3)] = (sin(Phase) / 2.0)im
  A[i(4), j(4)] = pow(cos(Phase / 2.0), 2)

  return A

end 

function RyGate(i::Index, j::Index, Phase)
  A = ITensor(i,j)

  A[i(1), j(1)] = pow(cos(Phase / 2.0), 2)
  A[i(1), j(2)] = sin(Phase) / 2.0
  A[i(1), j(3)] = sin(Phase) / 2.0
  A[i(1), j(4)] = pow(sin(Phase / 2.0), 2)
  A[i(2), j(1)] = -1.0 * sin(Phase) / 2.0
  A[i(2), j(2)] = pow(cos(Phase / 2.0), 2)
  A[i(2), j(3)] = -1.0 * pow(sin(Phase / 2), 2)
  A[i(2), j(4)] = sin(Phase) / 2.0
  A[i(3), j(1)] = -1.0 * sin(Phase) / 2.0
  A[i(3), j(2)] = -1.0 * pow(sin(Phase / 2.0), 2)
  A[i(3), j(3)] = pow(cos(Phase / 2.0), 2)
  A[i(3), j(4)] = sin(Phase) / 2.0
  A[i(4), j(1)] = pow(sin(Phase / 2.0), 2)
  A[i(4), j(2)] = -1.0 * sin(Phase) / 2.0
  A[i(4), j(3)] = -1.0 * sin(Phase) / 2.0
  A[i(4), j(4)] = pow(cos(Phase / 2.0), 2)

  return A

end 

function RzGate(i::Index, j::Index, Phase)
  A = ITensor(i,j)

  A[i(1), j(1)] = 1.0
  A[i(2), j(2)] = cos(Phase) -1.0 * sin(Phase)im
  A[i(3), j(3)] = cos(Phase) + sin(Phase)im
  A[i(4), j(4)] = 1.0

  return A

end 


##
#
# Measurements
#
##

function XMeasure(i::Index)
  A = ITensor(i)

  A[i(2)]=1
  A[i(3)]=1

  return A

end 

function ZMeasure(i::Index)
  A = ITensor(i)

  A[i(1)]=1
  A[i(4)]=-1

  return A

end 

function YMeasure(i::Index)
  A = ITensor(i)

  A[i(2)]=1im
  A[i(3)]=-1im

  return A

end 

function Project1(i::Index)
  A = ITensor(i)

  A[i(4)]=1

  return A

end 

function Project0(i::Index)
  A = ITensor(i)

  A[i(1)]=1

  return A

end 

function Trace(i::Index)
  A = ITensor(i)

  A[i(1)]=1
  A[i(4)]=1

  return A

end 

end