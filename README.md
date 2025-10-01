# PV-Battery-Hybrid-Power-System
MATLAB/Simulink model of a PV–Battery Hybrid Power System with simulation results, analysis, and documentation. Includes PV modeling, battery integration, and performance under varying load conditions.

📌 **Project Overview**

This project simulates a **PV–Battery hybrid system** using MATLAB/Simulink.  
The system integrates a photovoltaic (PV) array with a lithium-ion battery and is regulated using a **Maximum Power Point Tracking (MPPT) algorithm** and **PI controllers** to maintain stable DC bus voltage under varying solar irradiance and load conditions.  

⚡ **Key Features**

- PV array model with configurable irradiance and temperature.  
- MPPT algorithm (Perturb & Observe) to extract maximum power from PV.  
- Lithium-ion battery model for charging/discharging with cutoff and full-charge limits.  
- PI controllers for **Vbus** and **Ibus** stability.  
- PWM switching at 5 kHz for efficient converter control.  
- Simulation validates reliable hybrid power delivery with stable voltage and current.  

🛠 **Tools & Skills**

- MATLAB/Simulink  
- Power Electronics (DC–DC Converters)  
- Control Systems (PI controllers, MPPT)  
- Renewable Energy Systems Integration  

📂 **Repository Contents**

- `model.slx` → Simulink model (replace with actual file)  
- `MPPT_control.m` → MATLAB function implementing Perturb & Observe algorithm  
- `startup.m` → MATLAB script to initialize system parameters  
- `images/` → Simulation results (scope outputs, model diagram)  
- `Report.pdf` → Detailed report with objectives, methodology, results, and analysis  
- `README.md` → This project documentation  

📊 **Results**

Simulation scope outputs show:  

- **PV Performance** → Voltage and current stabilize at the maximum power point.  
- **Battery Response** → Smooth charging/discharging cycles maintain energy balance.  
- **Bus Voltage Regulation** → PI controllers keep DC bus voltage within limits.  

Example outputs:  

![PV Output]([PV-Battery-Hybrid-Power-System
/scope 1.png](https://github.com/iamsujitt/PV-Battery-Hybrid-Power-System/blob/main/scope%201.png))  
[![Battery Response](https://github.com/iamsujitt/PV-Battery-Hybrid-Power-System/blob/main/scope%202.png)

🚀 **How to Run**

1. Clone or download this repository:  
   ```bash
   git clone https://github.com/yourusername/PV-Battery-Hybrid-Power-System.git
2. Open model.slx in MATLAB Simulink.

3. Run startup.m to initialize workspace parameters.

4. Start simulation and observe PV, battery, and bus voltage responses.

📌 Author

Sujit Kumar Chaudhary
Electrical & Electronics Engineer | Power Systems & Renewable Energy

📧 iamsujit33@gmail.com
