
# An advanced makefile for the differentiation 
# Here we use the macros FC, FFLAGS, F90FLAGS and general rules for compiling 
# .f90 and .f files
# We also use the Macro OBJECTS to not have to keep track of the 
# object files in more than one place.
# The PHONY target clean has also been added


FC = gfortran
LD = gfortran
LDFLAGS = -fopenmp
FFLAGS = -O3
F90FLAGS = -O3 -g -fbacktrace -fbounds-check -fopenmp
EX = ./homework6.x


OBJECTS = homework6.o differentiate.o printdble.o xycoord.o metric.o trapezoidal2d.o
MODULES = xycoord.mod

.PHONY: clean

# Compile, run, process and open.
$(EX): $(MODULES) $(OBJECTS) 
	$(LD) $(LDFLAGS) $(OBJECTS) -o $(EX)



run: $(EX)
	$(EX)   

%.o : %.f90
	$(FC) $(F90FLAGS) -c $<

%.o : %.f
	$(FC) $(FFLAGS) -c $<

%.mod : %.f90
	$(FC) $(FFLAGS) -c $<

clean:
	rm -f $(OBJECTS) $(MODULES)  
