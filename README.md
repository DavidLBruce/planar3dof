# planar3dof
Planar 3 degree of freedom (X, Y, theta) simulation

Features:

 - Object oriented design with simulation models derived from a common base
   class with virtual methods.

 - Base class provides RK4 integrator for dynamic models

 - This simulation is a planar 3DOF with translational X, Y, and rotational
   theta (pitch or yaw) degrees of freedom.  There is no earth model.  There
   is not an explicit sense of up, just X and Y in a general plane.  It is 
   good for modeling dynamics over a short time interval such as a missile's
   endgame.

