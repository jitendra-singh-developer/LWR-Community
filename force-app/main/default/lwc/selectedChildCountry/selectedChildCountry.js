import { LightningElement , api} from 'lwc';

export default class SelectedChildCountry extends LightningElement {

    @api detail = 'Image hai bhai'
    @api count = 0;
    imageObj = [
        {
            id : 101 ,
            countryName : "India",
            capital :"New Delhi",
           detail : 'The capital of India is New Delhi. India is a peninsula, bound by the Indian Ocean in the south, the Arabian Sea on the west and Bay of Bengal in the east. The coastline of India is of about 7,517 km (4,671 mi) long.',
            name : "https://cdn.britannica.com/86/170586-050-AB7FEFAE/Taj-Mahal-Agra-India.jpg"
        },
        {
            id : 102,
            countryName : "Russia",
            capital :"Mosko",
           detail :'At 17,075,400 square kilometres (6,592,800 sq mi), Russia is the largest country in the world, covering more than one-eighth of the Earths inhabited land area. Russia is also the worlds eighth most populous nation with 143 million people as of 2012. Russia produces a lot of energy made from oil and natural gas',
            name : "https://s30876.pcdn.co/wp-content/uploads/Russia-1170x630.jpg"
        },
        {
            id : 103,
            countryName : "China",
            capital :"Beijing",
            detail:'China, officially the Peoples Republic of China (PRC), is a country in East Asia. It is the worlds most populous country, with a population of around 1.4 billion in 2019.[8] Covering approximately 9.6 million square kilometers (3.7 million mi2), it is the worlds third or fourth-largest country by area',
            name : "https://imageproxy.themaven.net//https%3A%2F%2Fwww.history.com%2F.image%2FMTYyODMxMTcyNDQ1OTM5NTUz%2Ftopic-china-gettyimages-565786575.jpg"
        }
    ];

}