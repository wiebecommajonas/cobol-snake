COBFLAGS = -Wall

all: compute_millis snake

snake: snake.cob
	cobc -x $(COBFLAGS) snake.cob

compute_millis: ComputeMillis.cob
	cobc -m $(COBFLAGS) ComputeMillis.cob

clean:
	rm snake
	rm ComputeMillis.dylib
