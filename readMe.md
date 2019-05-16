

# HZD Optimization Examples

This repo, **HZDOptimizationExamples**, is an MATLAB implementation extended from Hybrid Zero Dynamics Gait Optimization. The trajectory optimization with direct collocation is used as the main framework of the optimization.

## Preparations

### Setup MATLAB interface for IPOPT

1. Clone the repo in https://github.com/ebertolazzi/mexIPOPT to your computer. It is the MATLAB interface for IPOPT which works welll with the recent MATLAB distributions.
2. In the subfolder **lib**, run the m-file which is for your computer's OS (e.g. for the Windows user, run compile_win.m).
3. Go to the subfolder **binary\dll**, the mex file **ipopt** should be generated.
4. Copy the path of the subfolder **dll**. Now go back to the repo,  and update the IPOPT path in trajOptConfig.m (line 64) in the example folder (blockMove, compassGait, rollerPendulum) for the example you want to run.


## Solve the HZD Optimization

### This repo contains the following examples

1. Moving block example, run **blockMove_HSM_Main.m** to solve the optimized trajectory, where different cost functions 'timeOptimal' or 'minNorm' can be choosen (line 31 or 32).
2. Roller pendulum example, run **rollerPendulum_HSM_Main.m** to solve the optimized trajectory. Once the trajectory is generated, run **rollerPendulum_Simulation.m** will show the simulation result (PD control) and its comparison to the  optimized trajectory generated from the HZD Optimization.
3. Compass gait example, run **compassGait_HSM_Main** to solve the optimized trajectory (**compassGait_HSM__fmincon_Main.m** is an equivelent implementation using fmincon as the optimization solver). Once the trajectory is generated, run **compassGait_HSM_Simulation_Main.m** will show the simulation result (feedback linearization with PD control) and its comparison to the trajectory generated from simulation.

