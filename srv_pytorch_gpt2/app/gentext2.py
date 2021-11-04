
import torch

from transformers import (
    GPT2LMHeadModel,
    GPT2Tokenizer,
)

tokenizer = GPT2Tokenizer.from_pretrained("gpt2")
model = GPT2LMHeadModel.from_pretrained("gpt2")

sentence_prefix = "I eat"

input_ids = tokenizer.encode(
    sentence_prefix,
    add_special_tokens=False,
    return_tensors="pt",
    add_space_before_punct_symbol=True
)

output_ids = model.generate(
    input_ids=input_ids,
    do_sample=True,
    max_length=20,  # desired output sentence length
    pad_token_id=model.config.eos_token_id,
)[0].tolist()

generated_text = tokenizer.decode(
    output_ids,
    clean_up_tokenization_spaces=True)

print(generated_text)