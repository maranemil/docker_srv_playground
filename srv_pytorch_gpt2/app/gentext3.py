import torch
from transformers import GPT2Tokenizer, GPT2LMHeadModel
from Interpreter import Interpreter


def Phi(x):
    global model
    result = model(inputs_embeds=x)[0]
    return result  # return the logit of last word


model_path = "gpt2"
model = GPT2LMHeadModel.from_pretrained(model_path, output_attentions=True)
tokenizer = GPT2Tokenizer.from_pretrained(model_path)

input_embedding_weight_std = (
    model.get_input_embeddings().weight.view(1, -1)
        .std().item()
)

text = "I disapprove of what you say , but"
inputs = tokenizer.encode_plus(text, return_tensors='pt',
                               add_special_tokens=True,
                               add_space_before_punct_symbol=True)
input_ids = inputs['input_ids']

with torch.no_grad():
    x = model.get_input_embeddings()(input_ids).squeeze()

interpreter = Interpreter(x=x, Phi=Phi,
                          scale=10 * input_embedding_weight_std,
                          words=text.split(' ')).to(model.device)

# This will take sometime.
interpreter.optimize(iteration=1000, lr=0.01, show_progress=True)
interpreter.get_sigma()
interpreter.visualize()
