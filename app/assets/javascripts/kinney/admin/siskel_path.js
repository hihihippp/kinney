function siskelPath(filename){
  if (filename.match('-')){
    // FIXME: Make this configurable!
    var url = 'http://siskel.lib.ncsu.edu/SLI';
    var name = filename.split('-')[0];
    return url + '/' + name + '/' + filename + '/' + filename;
  }
}