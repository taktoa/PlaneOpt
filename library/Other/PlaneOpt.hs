{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- | The main PlaneOpt library
module Other.PlaneOpt (module Other.PlaneOpt) where

import           Atmosphere
import           Data.SBV
import           Other.PlaneOpt.Xfoil as Other.PlaneOpt
-- GENERATE: import New.Module as Other.PlaneOpt

{-
MISSION

W_f / W_0 = 1.06 * (1 - exp(-(0.0506 + e_loit * 1 hr + e_cruise * 7.217 hr)))
e_loit = C_loit / LDR_max
e_cruise = C_cruise / LDR_max

---

(C_loit C_cruise LDR_max) <=> (W_f/W_0)
-}

{-
WEIGHT

W_empty = rho_st V_st + rho_c V_c + rho_av V_av + 2 W_engine
W_fuel = rho_f V_f
W_0 = W_fuel + W_empty
V_st = 2*A_sw*l_w + A_r delta_r + A_w w_t (c_t^2 / c_w^2) + d_b pi (2 r_f + d_st) d_st
V_c = d_b (pi r_f^2 - A_bf)
V_av = pi/3 d_av^3 tan^2(phi_nc)
V_f = 2 l_w A_fw + d_b A_bf
where
r_f = d_fi / 2
A_bf = r_f^2 acos(z_fc / r_f) - z_fc sqrt(r_f^2 - z_fc^2)
d_b = d_t - d_av
A_w = A_sw + A_fw
l_w = x_f (3 c_w^2 - 3 c_w x_f tan(phi_w) + x_f^2 tan^2(phi_w)) / (3 c_w^2)
x_f = w_w - d_st - r_f

---

rho_c  ~= 10 lbs / ft^3 = 160 kg/m^3 -- from RAND document
rho_f  ~= 0.81 kg/L     = 810 kg/m^3 -- density of Jet-A
rho_av ~=                 500 kg/m^3 -- arbitrary
rho_st ~=                 900 kg/m^3 -- arbitrary
W_engine defined by engine choice

---
(A_fw A_sw A_r c_t c_w d_av d_fi d_st d_t delta_r phi_nc phi_w w_t w_w z_fc) <=> (W_empty W_fuel W_0)

-}

{-
AERODYNAMICS

c_D = c_d + (c_L^2 / (pi e AR))
c_L = c_l * (alpha / 1 rad) * (AR / (AR + 2))
AR = w_w^2 / S
S = c/2 cot(phi_w) (c - c cot(phi_w) cos (phi_w) + 2 x_f cos(phi_w) - x_f^2 sin(phi_w))
e = 1 / (1.05 + 0.007*pi*AR)
from: http://www.fzt.haw-hamburg.de/pers/Scholz/OPerA/OPerA_PUB_DLRK_12-09-10.pdf


---

alpha
c
c_d
c_l
d_fi
d_st
phi_w
w_w

-}

{-


-}

data PlaneConfig = PlaneConfig { p_C_cruise :: SDouble
                               , p_C_loit   :: SDouble
                               , p_         :: SDouble
                               } deriving (Eq, Show)


main :: IO ()
main = putStrLn "hi"
