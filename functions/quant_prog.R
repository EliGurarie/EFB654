# 1. Create the data
quant_prog <- data.frame(
  Year = c(1980, 1981, 1994, 1996, 2007, 2012, 2019),
  Event = c(
    "Feasibility of quantum computing described", 
    "Simulating quantum processes in nature",
    "Shor's factoring algorithm introduced",
    "Grover's search algorithm introduced",
    "First 'commercial' quantum computer (D-Wave)",
    "Quantum supremacy concept described",
    "IBM releases 20-qubit system"
  ),
  Category = c(
    "Theory",      # 1980
    "Theory",      # 1981
    "Algorithm",   # 1994
    "Algorithm",   # 1996
    "Commercial", # 2007
    "Theory",      # 2012
    "Commercial"  # 2019
  )
)