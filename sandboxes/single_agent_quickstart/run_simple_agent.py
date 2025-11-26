import grid2op
from grid2op.Agent import RandomAgent
from grid2op.Reward import L2RPNReward

EPISODES = 5

def main():
    env = grid2op.make("l2rpn_case14_sandbox", reward_class=L2RPNReward)
    agent = RandomAgent(action_space=env.action_space)

    for ep in range(EPISODES):
        obs = env.reset()
        done = False
        total_reward = 0.0
        steps = 0

        while not done:
            action = agent.act(obs, reward=0.0, done=False)
            obs, reward, done, info = env.step(action)
            total_reward += reward
            steps += 1

        print(f"Episode {ep + 1}: reward: {total_reward}, steps: {steps}, done reason: {info.get('exception', 'normal')}")

    env.close()

if __name__ == "__main__":
    main()