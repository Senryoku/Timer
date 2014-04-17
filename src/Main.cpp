#include "Timer.hpp"

int main()
{
	Timer T(true);
	while(T.microseconds() < std::chrono::microseconds(1000000))
		std::cout << "Milliseconds : " << T 
			<< "\tMicro : " << T.runningTime<std::chrono::microseconds>().count() 
			<< "\tNano : " << T.nanoseconds().count() 
			<< std::endl;
}