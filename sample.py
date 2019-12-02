import gym
env = gym.make('CartPole-v0')
for i_episode in range(20):
    observation = env.reset()
    for t in range(1000):
        env.render()
        print(observation)
        action=int(input())# must be 0(left) or 1(right)
        observation, reward, done, info = env.step(action)

env.close()
