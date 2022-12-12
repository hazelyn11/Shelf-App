from flask import Blueprint, jsonify
import json
from src import db
from flask import request

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
        WHERE bookShelf.shelfID = {0};
    '''
   cur.execute(query.format(id))
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

# Access all books a reader has read
@views.route('/completed_books')
def completed_books():
   cur = db.get_db().cursor()
   query = '''
        SELECT book.title as label, book.ISBN as value
        FROM book join bookReader on book.ISBN = bookReader.bookISBN
        WHERE bookReader.readerUsername = "hazelyna11";
    '''
   cur.execute(query)
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

# Send book to be added to the shelf
@views.route('/add_book', methods=['POST'])
def add_book():
   cur = db.get_db().cursor()
   ShelfID = request.form['ShelfID']
   ISBNToAdd = request.form['ISBNToAdd']
   cur.execute(f'INSERT INTO bookShelf VALUES({ShelfID}, {ISBNToAdd});')
   db.get_db().commit()
   cur.connection.commit()
   return(f'added to shelf {ShelfID}, {ISBNToAdd}')

# Display titles of books available at a certain bookstore
@views.route('/books')
def books():
   cur = db.get_db().cursor()
   query = '''
        SELECT book.title as label, bookstoreBooks.bookISBN as value
        FROM bookstoreBooks join book on book.ISBN = bookstoreBooks.bookISBN
        WHERE bookstoreBooks.bookstoreID = 01;
    '''
   cur.execute(query)
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

# Update book stock
@views.route('/update_book', methods=['POST'])
def update_book():
   cur = db.get_db().cursor()
   new_stock = request.form['stock']
   book_to_update = request.form['book_to_update']
   cur.execute(f'UPDATE bookstoreBooks SET total_copies_in_stock = {new_stock} WHERE bookISBN = {book_to_update} & bookstoreID = 01;')
   db.get_db().commit()
   cur.connection.commit()
   return(f'updated with {new_stock}')

# Get location of the next event the author will be attending
@views.route('/next_event_info')
def next_event_info():
   cur = db.get_db().cursor()
   query = '''
        SELECT bookstore.bookstore_location as Location, events.event_time as Time
        FROM events join bookstore on events.bookstoreID = bookstore.id
        WHERE events.authorUsername = "srooney"
        LIMIT 1;
    '''
   cur.execute(query)
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)