#The numba warning is fine because we are using a different fast backend lightsim2grid
import grid2op
from lightsim2grid import LightSimBackend
env_name = "l2rpn_case14_sandbox"  # or any other name.
# env = grid2op.make(env_name, backend=LightSimBackend())
# print(env.backend.__class__.__name__)
