# Lithium-Ion-Battery-Reduced-Order-Model-FDM-Pade-Approximation-Optimization-Based-

Lithium-Ion Battery Single Particle Model Tutorial 

Lithium-Ion Battery Single Particle Model is the code to simulate the lithium-ion battery cell model.  

The code contains various models. 

1) Finite Difference Method Model without Degradation. (FDM Model) 
2) Finite Difference Method Model with Linearized Degradation. (FDM LM Model) 
3) Finite Difference Method Model with Nonlinear Degradation. (FDM NM Model) 
4) Pade Approximation Model without Degradation (Pade Model) 
5) Pade Approximation Model with Degradation (Pade-D Model) 
6) Optimization-Based Model (O-B Model)


1) Simulink (Open “battery\_cell\_model.slx”) 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.001.jpeg)

Battery Cell  

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.002.jpeg)

Negative Electrode 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.003.jpeg)

Positive Electrode

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.004.jpeg)

2) MATLAB File 

To run the code, open the file “RUN\_ROM\_battery\_cell.m” 

The following steps are the setup to run the battery cell model. 

(1) You have to choose what model you will run. (FDM Model, FDM\_LM Model, FDM\_NM Model etc.) 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.005.jpeg)

(2) After choosing the battery cell model, you have to select what parameters you will use. Skip this part if you choose the model that does not contain a degradation model 

In this code, we have two options. The first is ‘SD’ (General Parameters). The second is ‘BD’ (Increased Parameters) 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.006.png)

(3) Select the model’s order 

FDM Model & FDM LM Model 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.007.jpeg)

FDM NM Model 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.008.png)

In FDM NM Model, we have to load the nonlinear map to calculate the negative surface concentration. There are two nonlinear maps. 'degradation\_map\_SD.mat' is for ‘SD’. 'degradation\_map\_BD.mat' is for ‘BD’. 

Pade Model & Pade-D Model 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.009.jpeg)

O-B Model 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.010.jpeg)

(4) Setup the input current 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.011.png)

If you want to use the 1-D look up table block you have to setup the ‘t’ and ‘u’ variables. 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.012.png)

Or you can setup the various input current using Simulink block as shown above. (Sinusoid wave, square wave etc.) 

(5) Initial Condition 

In initial condition part, the only thing you have to change is “line 137”.  

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.013.png)

(6) Linearized side reaction current density coefficients (minor step) 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.014.png)

7) Setup the time range 

![](/Readme/Aspose.Words.216cfff8-f125-45da-a508-b96c3d48f685.017.png)



