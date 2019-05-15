#!C:\msys64\usr\bin\bash.exe --login
source shell mingw64

echo "Job 6"

cd /c/builds/workspace/FreeFem-sources-windows7 \
  && git clone https://github.com/FreeFem/FreeFem-sources.git -b develop \
  && cd FreeFem-sources \
  && autoreconf -i \
  && ./configure --prefix=/builds/workspace/freefem \
  && ./3rdparty/getall -a \
  && cd 3rdparty/ff-petsc \
	&& make petsc-slepc \
	&& cd - \
	&& ./reconfigure \
  && make

  if [ $? -eq 0 ]
  then
    echo "Build process complete"
  else
    echo "Build process failed"
    exit 1
  fi

  # check
  make check

  if [ $? -eq 0 ]
  then
    echo "Check process complete"
  else
    echo "Check process failed"
  fi

  # install
  make install

  if [ $? -eq 0 ]
  then
    echo "Install process complete"
  else
    echo "Install process failed"
  fi
