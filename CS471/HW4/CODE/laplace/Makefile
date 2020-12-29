

FC = gfortran
LD = gfortran
LDFLAGS = 
FFLAGS = -O3
F90FLAGS = -O3 -g -fbacktrace -fbounds-check
EX = ./hw4laplace.x


OBJECTS = hw4laplace.o differentiate.o printdble.o xycoord.o metric.o trapezoidal2d.o
MODULES = xycoord.mod

.PHONY: clean

# Compile, run, process and open.
$(EX): $(MODULES) $(OBJECTS) 
	$(LD) $(OBJECTS) -o $(EX)

run: $(EX)
	$(EX) >out.txt
plot: $(EX)
	$(EX) > out.txt
	nohup matlab < plotgrid.m > grid.txt
	nohup matlab  < printerror.m > error.txt   

%.o : %.f90
	$(FC) $(F90FLAGS) -c $<

%.o : %.f
	$(FC) $(FFLAGS) -c $<

%.mod : %.f90
	$(FC) $(FFLAGS) -c $<

clean:
	rm -f $(OBJECTS) $(MODULES) $(EX)  output.txt x.txt y.txt grid.txt error.txt xycoord.mod

