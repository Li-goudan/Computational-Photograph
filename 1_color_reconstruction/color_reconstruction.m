%% color reconstruction

close all;
clear;
clc;

% here load the images
R = imread('red.pgm');
G = imread('green.pgm');
B = imread('blue.pgm');

% call the gui with the loaded images
my_gui(R,G,B);
