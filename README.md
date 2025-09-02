# FPGA Project: Digital Clock (Nexys 3)
## 🎯 Project Overview
This project implements a **digital clock** on the Digilent Nexys 3 FPGA board using **hierarchical VHDL design**.  
The clock displays time between **00:00 and 23:59** on a 4-digit 7-segment display.

The design demonstrates:
- Frequency division
- Modular design
- Time counting
- Seven-segment multiplexed display

---

## ⚙️ Implementation Details
- **Language:** VHDL  
- **Toolchain:** Xilinx ISE (Spartan-6)  
- **Board:** Digilent Nexys 3  

### Part 1 – Clock Divider
- Input: 100 MHz onboard clock.  
- Output: 500 Hz signal (2 ms period).  
- Used for multiplexing and driving counter.  

### Part 2 – 7-Segment Controller
- Scans 4 digits at 500 Hz.  
- Multiplexing ensures persistence of vision.  
- Input: 4 digits (0–9).  
- Output: `AN` (anodes), `CATHODES` (7-seg cathodes).  

### Part 3 – Clock Counter
- Counts minutes (0–59) and hours (0–23).  
- Uses **arrays** to convert time to BCD digits.  
- Maps values to 7-segment encoding.  
- For testing: minutes increment every 100 ms instead of 60 s.  

### Part 4 – Hierarchical Top Module
- Instantiates:
  - `ClockDivider`  
  - `clockCounter`  
  - `sevenSegmentController`  
- Drives the full digital clock system.  


---

## 📝 Note
This project is shared as a **Digital Clock Application Challenge**, demonstrating hierarchical design and timekeeping logic in VHDL.
