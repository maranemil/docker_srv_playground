
import torch
from transformers import GPT2LMHeadModel, GPT2Tokenizer

# initialize tokenizer and model from pretrained GPT2 model
tokenizer = GPT2Tokenizer.from_pretrained('gpt2')
model = GPT2LMHeadModel.from_pretrained('gpt2')

sequence = "Here is my input"

inputs = tokenizer.encode(sequence, return_tensors='pt')
# we pass a maximum output length of 200 tokens
# outputs = model.generate(inputs, max_length=100, do_sample=True)
outputs = model.generate(
    inputs, max_length=200, do_sample=True, temperature=5
)
# outputs = model.generate(
#     inputs, max_length=200, do_sample=True, top_k=50
# )
text = tokenizer.decode(outputs[0], skip_special_tokens=True)


print(text)

"""
pip install transformers
pip install transformers[torch]
pip install transformers[tf-cpu]
"""

# https://pypi.org/project/transformers/
# https://huggingface.co/transformers/v3.5.1/installation.html
# https://huggingface.co/transformers/installation.html
# https://www.youtube.com/watch?v=YvVQgvAz9dY
# https://towardsdatascience.com/text-generation-with-python-and-gpt-2-1fecbff1635b
