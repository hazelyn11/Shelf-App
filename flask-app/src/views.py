from flask import Blueprint, jsonify
import json
from src import db

views = Blueprint('views', __name__)

# Sort books a reader has completed with highest rating first
@views.route('/rating_desc')
def rating_desc():
   cur = db.get_db().cursor()
   query = '''
        SELECT book.title as Title, bookReader.rating as Rating
        FROM book join bookReader on book.ISBN = bookReader.bookISBN
        WHERE bookReader.readerUsername = "hazelyna11"
        ORDER BY bookReader.rating DESC;
    '''
   cur.execute(query)
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

# Sort books a reader has completed with lowest rating first
@views.route('/rating_asc')
def rating_asc():
   cur = db.get_db().cursor()
   query = '''
        SELECT book.title as Title, bookReader.rating as Rating
        FROM book join bookReader on book.ISBN = bookReader.bookISBN
        WHERE bookReader.readerUsername = "hazelyna11"
        ORDER BY bookReader.rating ASC;
    '''
   cur.execute(query)
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

# Display titles of shelves a reader has created
@views.route('/reader_shelves')
def reader_shelves():
   cur = db.get_db().cursor()
   query = '''
        SELECT title as label, id as value
        FROM shelf
        WHERE readerUsername = "hazelyna11";
    '''
   cur.execute(query)
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

# Navigate to a specific shelf and display books on that shelf
@views.route('/reader_shelves/<id>', methods=['GET'])
def reader_shelves_id(id):
   cur = db.get_db().cursor()
   query = '''
        SELECT book.title as Title
        FROM bookShelf join book on bookShelf.bookISBN = book.ISBN
        WHERE bookShelf.shelfID = {0}
    '''
   cur.execute(query.format(id))
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)