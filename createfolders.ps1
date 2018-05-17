#!/bin/bash
For ($i=0; $i -le 30; $i++) {
     
     mkdir "testfolder$i"
     cd "testfolder$i"
     echo "This is in level $i" > "testfile$i.txt"    

    }
