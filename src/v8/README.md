	!TKIN_VIS is the average turbulent kinematic viscosity
	!YPAD is the y coordinates of the mesh
	!YHAD(n) is the distance between YPAD(n) & YPAD(n-1)
	!UMAX= MAX VEL IN THE FLOW
	!UAVG= AVG VEL IN THE FLOW
	!UTAU1= FRICTION VELOCITY AT THE WALL WHERE STRESS IS HIGHER
	!UTAU2= FRICTION VELOCITY AT THE WALL WHERE STRESS IS LESS
	
	
		        !convergence criteria
		if(ERROR>CONV_CRIT .AND. ITERATIONS<MAX_ITER )then
