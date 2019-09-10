function projector(param, fn) {
  return fn(param);
}

function toUpperCase(param) {
  return projector(param, function(param) {
    return String.prototype.toUpperCase.call(param);
  });
}

function toLowerCase(param) {
  return projector(param, function(param) {
    return String.prototype.toLowerCase.call(param);
  });
}

var uppercased = projector('WHat Is goIng on', toUpperCase);
console.log(uppercased);

var lowercased = projector('I am at A lOSs', toLowerCase);
console.log(lowercased);