# Introduction
We contribute here a Matlab-based optimization software package based on our novel optimization algorithm named Balancing Composite Motion Optimization (BCMO). It is noted that this proposed algorithm is constructed without algorithm-specific parameters, the users can directly apply it to solve any unconstrained optimization problems without tuning special parameters. Some detailed definitions and instructions are also presented into the codes to help the users easily modify it for personal research and uses. We show below some necessary information of our BCMO package including
1. Structure of BCMO software package: 
- Main.m: the main function for implementing BCMO to solve unconstrained optimization problems.
- OptimProblem.m: the function defining the objective function of unconstrained optimization problems.
- BCMO.m: the 100-line Matlab codes of BCMO solver.
2. How to solve unconstrained optimization problems by BCMO software package: 
- Define the objective function in OptimProblem.m Define the necessary inputs (dimension, population size, maximum generation, bounds, etc.) in Main.m
- Run Main.m and wait until the optimization process done.
- Enjoy results

# Contributors
- Thang Le-Duc
- Quoc-Hung Nguyen
- Hung Nguyen-Xuan

# References:
Thang Le-Duc, Quoc-Hung Nguyen, H. Nguyen-Xuan, Balancing Composite Motion Optimization, Information Sciences, in press, 2020 https://www.sciencedirect.com/science/article/pii/S0020025520300773
