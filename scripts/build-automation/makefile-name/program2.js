console.log('Inside program2.js');
var netflixPayload = [
  {
    "name": "New Releases",
    "videos": [
      {
        "id": 70111470,
        "title": "Die Hard",
        "boxart": "http://cdn-0.nflximg.com/images/2891/DieHard.jpg",
        "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
        "rating": 4.0,
        "bookmark": []
      },
      {
        "id": 654356453,
        "title": "Bad Boys",
        "boxart": "http://cdn-0.nflximg.com/images/2891/BadBoys.jpg",
        "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
        "rating": 5.0,
        "bookmark": [
          {
            "id": 432534,
            "time": 65876586
          }
        ]
      }
    ]
  },
  {
    "name": "Dramas",
    "videos": [
      {
        "id": 65432445,
        "title": "The Chamber",
        "boxart": "http://cdn-0.nflximg.com/images/2891/TheChamber.jpg",
        "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
        "rating": 4.0,
        "bookmark": []
      },
      {
        "id": 675465,
        "title": "Fracture",
        "boxart": "http://cdn-0.nflximg.com/images/2891/Fracture.jpg",
        "uri": "http://api.netflix.com/catalog/titles/movies/70111470",
        "rating": 5.0,
        "bookmark": [
          {
            "id": 432534,
            "time": 65876586
          }
        ]
      }
    ]
  }
];

var reducedSet = netflixPayload.filter(function(item) {
  return item.name === "Dramas";
}).map(function(item) {
  return {
    name: item.name,
    videos: item.videos.map(function(reducedSet) {
      return {
        id: reducedSet.id,
        title: reducedSet.title
      }
    })
  }
});

console.log(JSON.stringify(reducedSet, null, '\t'));