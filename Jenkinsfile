pipeline {
    agent{
        label "windows"
    }
    
    options {
        timestamps
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
    }

    stages{
        stage("Build"){
            steps{
                echo "========Configuring Projects========"
                bat '''pip install --user git+https://bitbucket.org/lindenlab/autobuild#egg=autobuild
git clone https://vcs.firestormviewer.org/fs-build-variables varz
del /Q C:\\cygwin64\\bin\\builder.sh
C:\\cygwin64\\bin\\echo.exe "#!/bin/bash" > builder.sh
C:\\cygwin64\\bin\\echo.exe "cd /cygdrive/c/builder/workspace/%JOB_NAME%" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "export AUTOBUILD_VARIABLES_FILE=/cygdrive/c/builder/workspace/%JOB_NAME%/varz/variables" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "export AUTOBUILD_VSVER=150" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "dos2unix -n $AUTOBUILD_VARIABLES_FILE $AUTOBUILD_VARIABLES_FILE.sh" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "source $AUTOBUILD_VARIABLES_FILE.sh" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "cp $AUTOBUILD_VARIABLES_FILE.sh ~/varz" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "export AUTOBUILD_VARIABLES_FILE=\\"%WORKSPACE%\\varz\\variables\\"" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "autobuild installables edit fmodstudio platform=windows hash=bd3f89aa9156d53ad1e2b36732c55388 url=file:///c:/firestorm/3p-fmodstudio/fmodstudio-2.00.11-windows-202301211.tar.bz2" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "autobuild installables edit fmodstudio platform=windows64 hash=4ec8c3598ce48ea9831cb6e75b47ccc6 url=file:///c:/firestorm/3p-fmodstudio/fmodstudio-2.00.11-windows64-202331947.tar.bz2" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "echo Adjusted installables" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "autobuild configure -A 64 -c ReleaseFS_open -- --fmodstudio --chan FS_ci_zdev --package -DLL_TESTS:BOOL=FALSE" >> builder.sh
C:\\cygwin64\\bin\\echo.exe "autobuild build -A 64 -c ReleaseFS_open --no-configure" >> builder.sh
move builder.sh C:\\cygwin64\\bin\\builder.sh

C:\\cygwin64\\bin\\bash --login /bin/builder.sh

del /Q C:\\cygwin64\\bin\\builder.sh'''
            }
            post{
                always{
                    echo "========Configuration has finished========"
                }
                success{
                    echo "========Configured Successfully========"
                }
                failure{
                    echo "========Configuration Failed========"
                }
            }
        }
    }
    post{
        always{
            echo "========Jobs finished========"
        }
        success{
            echo "========jobs executed successfully ========"
        }
        failure{
            echo "========jobs execution failed========"
        }
    }
}