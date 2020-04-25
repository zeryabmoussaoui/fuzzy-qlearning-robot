# Fuzzy Q-Learning Robot

This project provides a proof of concept for Fuzzy Q Learning applied to mobile robots.
Simulations and environment only require GNU Octave, this should also work on Matlab, but we advice you to use GNU Octave.
The main propose is to be able to benchmark classical and Reinforced Fuzzy logics

Warning : source code needs a serious refactoring.

**Authors :** [El Hacene Chabane](https://www.linkedin.com/in/el-hacene-chabane-9855b6123/), [Oussama Derouiche](https://www.linkedin.com/in/oussama-derouiche-aab0a4136/), [Zeryab Moussaoui](https://fr.linkedin.com/in/zeryab-moussaoui-9a728029),

## Installation
* Download the github project (zip)
* Unzip and copy all files in your GNU Octave current directory.

## How to

Multiple controllers for several environment can be executed :

| Environment   | Purpose | Controller | File to execute | 
| ------------- | ------------- | ------------- | ------------- |
| Free  | Goal Reach | FLC49  | [MAIN.m](./1.fuzzy%20controller/1.Goal%20Reach/MAIN.m") |
| 4 walls | Obstacle Avoidance | FLC27  |[MAIN.m](./1.fuzzy%20controller/2.Obstacle%20avoidance/MAIN.m)|
| 4 walls and 4 obstacles | Goal Reach and Obstacle Avoidance | FLC49/27  | [MAIN.m](./1.fuzzy%20controller/4.Goal%20Reach%20and%20Obstacle%20avoidance%20(%20chamber%20)/MAIN.m)|
| Free | Learning Goal Reach | R-FLC20  | [MAIN_RL3_ZMO4.m](./2.Q_fuzzy%20controller/Goal%20Reach/20%20rules/1.Learning/MAIN_RL3_ZMO4.m)|
| Free |  Goal Reach | RL-FLC20  | [MAIN_test.m](./2.Q_fuzzy%20controller/Goal%20Reach/20%20rules/2.test%20itetrations/MAIN_test.m)|
| Free | Learning Goal Reach | RL-FLC49  | [MAIN_RL3_ZMOH5.m](./2.Q_fuzzy%20controller/Goal%20Reach/Zer5_H%2049%20rule/MAIN_RL3_ZMOH5.m)|
| 4 walls | Learning Obstacle Avoidance | RL-FLC27  | [MAIN_obs_RL1.m](./2.Q_fuzzy%20controller/Obstacle%20avoidance/version%202/MAIN_obs_RL1.m)|

## Related Publications:

El Hacene Chabane, Oussama Derouiche.  *National Polytechnical School of Algiers June 2018*. **Implementation of a Fuzzy Reinforcement Learning Control using 2D VSLAM** **[PDF](https://docdro.id/T6DgsSs)**



