import { LightningElement,api } from 'lwc';

export default class ChildCountry extends LightningElement {
   @api isTrue = false;
   @api country = "";
   @api detail ="";
   @api imageUrl = "";
   save(){
       this.isTrue = true;
       if(this.country == 'India'){
          this.detail = 'The capital of India is New Delhi. India is a peninsula, bound by the Indian Ocean in the south, the Arabian Sea on the west and Bay of Bengal in the east. The coastline of India is of about 7,517 km (4,671 mi) long. India has the third largest military force in the world and is also a nuclear weapon state.'; 
          this.imageUrl= "https://cdn.britannica.com/86/170586-050-AB7FEFAE/Taj-Mahal-Agra-India.jpg "; 
       }else if(this.country == 'Russia')
       {
           this.detail = "At 17,075,400 square kilometres (6,592,800 sq mi), Russia is the largest country in the world, covering more than one-eighth of the Earth's inhabited land area. Russia is also the world's eighth most populous nation with 143 million people as of 2012. Russia produces a lot of energy made from oil and natural gas.";
           this.imageUrl = "https://s30876.pcdn.co/wp-content/uploads/Russia-1170x630.jpg";
       }else if(this.country == 'China'){
           this.detail = "China, officially the People's Republic of China (PRC), is a country in East Asia. It is the world's most populous country, with a population of around 1.4 billion in 2019. Covering approximately 9.6 million square kilometers (3.7 million mi2), it is the world's third or fourth-largest country by area.";
           this.imageUrl = "https://imageproxy.themaven.net//https%3A%2F%2Fwww.history.com%2F.image%2FMTYyODMxMTcyNDQ1OTM5NTUz%2Ftopic-china-gettyimages-565786575.jpg";
       }else if(this.country == 'America'){
           this.detail = 'The United States of America is the worlds third largest country in size and nearly the third largest in terms of population. Located in North America, the country is bordered on the west by the Pacific Ocean and to the east by the Atlantic Ocean. Along the northern border is Canada and the southern border is Mexico.';
           this.imageUrl = "https://s30876.pcdn.co/wp-content/uploads/United-States-of-America-1170x630.jpg";
       }else if(this.country == 'Japan'){
           this.detail = 'Japan (Japanese: 日本; Romanised as nihon or nippon) is a country in East Asia. It is a group of many islands close to the east coast of Korea, China and Russia. The Pacific Ocean is to the east of Japan and the Sea of Japan is to the west. Most people in Japan live on one of four of the islands.';
           this.imageUrl = "https://s30876.pcdn.co/wp-content/uploads/Japan-1170x630.jpg";
       }
           
       }
   }