import timm
import torch
from skimage.transform import resize
import argparse
import os
import json
import imageio

parser = argparse.ArgumentParser(description='Description of your program')

parser.add_argument('-m','--model',required=True)
parser.add_argument('-i','--image',required=True)

args = parser.parse_args()

model_name = args.model
image_path = args.image


model = timm.create_model(model_name,num_classes=1,pretrained=True)

os.system(f'wget {image_path}')

img = imageio.imread('dog.jpg')

img_resize=resize(img,(224,224,3)).astype('uint8')
img_resize.shape

img_tensor = torch.tensor(img_resize).permute(2,0,1).type(torch.float32)

y= model(img_tensor.unsqueeze(0))

output_dict = {"predicted":"dog","confidence": y.item()}
json_dict = json.dumps(output_dict)
print(json_dict)
