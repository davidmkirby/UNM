# Makefile5 types

FC = gfortran
LD = gfortran
LDFLAGS = 
FFLAGS = -O3
F90FLAGS = -O3 -g -fbacktrace -fbounds-check


EX = ./flockingbirds.x


OBJECTS =  values.o RK4_leader.o  frames.o repelforce.o feederbird.o flockingbird.o
MODULES = values.mod RK4_leader.mod repelforce.mod frames.mod feederbird.mod

.PHONY: clean

# Compile, run, process and open.
$(EX): $(MODULES) $(OBJECTS) 
	$(LD) $(OBJECTS) -o $(EX)

graph:$(EX)
	$(EX) 
	nohup matlab -nosplash -nodisplay -r plot_mat > out.txt
#	open -a preview grid.eps
movie:
	ffmpeg -r 4 -i birds_%05d.jpg -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" movie.mp4


run: $(EX)
	$(EX)   

%.o : %.f90
	$(FC) $(F90FLAGS) -c $<

%.o : %.f
	$(FC) $(FFLAGS) -c $<

%.mod : %.f90
	$(FC) $(FFLAGS) -c $<

clean:
	rm -f $(OBJECTS) $(MODULES) $(EX)  *.txt *.jpg nohup.out out.txt xy.txt


